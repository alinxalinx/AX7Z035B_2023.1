proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000

start_step init_design
set rc [catch {
  create_msg_db init_design.pb
  set_property design_mode GateLvl [current_fileset]
  set_property webtalk.parent_dir Y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.cache/wt [current_project]
  set_property parent.project_path Y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.xpr [current_project]
  set_property ip_repo_paths {
  y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.cache/ip
  Y:/project/zynq_ip_repo/alinx/ov5640_ip
  Y:/ax/ax7010/vivado_project_b/ov5640_ip
} [current_project]
  set_property ip_output_repo y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.cache/ip [current_project]
  add_files -quiet Y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.runs/synth_1/alinx_ov5640.dcp
  add_files -quiet Y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.runs/cmos_in_buf_synth_1/cmos_in_buf.dcp
  set_property netlist_only true [get_files Y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.runs/cmos_in_buf_synth_1/cmos_in_buf.dcp]
  read_xdc -mode out_of_context -ref cmos_in_buf -cells U0 y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.srcs/sources_1/ip/cmos_in_buf/cmos_in_buf_ooc.xdc
  set_property processing_order EARLY [get_files y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.srcs/sources_1/ip/cmos_in_buf/cmos_in_buf_ooc.xdc]
  read_xdc -ref cmos_in_buf -cells U0 y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.srcs/sources_1/ip/cmos_in_buf/cmos_in_buf/cmos_in_buf.xdc
  set_property processing_order EARLY [get_files y:/project/zynq_ip_repo/alinx/ov5640_ip/alinx_ov5640.srcs/sources_1/ip/cmos_in_buf/cmos_in_buf/cmos_in_buf.xdc]
  link_design -top alinx_ov5640 -part xc7z020clg400-2
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
}

start_step opt_design
set rc [catch {
  create_msg_db opt_design.pb
  catch {write_debug_probes -quiet -force debug_nets}
  opt_design 
  write_checkpoint -force alinx_ov5640_opt.dcp
  report_drc -file alinx_ov5640_drc_opted.rpt
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
}

start_step place_design
set rc [catch {
  create_msg_db place_design.pb
  catch {write_hwdef -file alinx_ov5640.hwdef}
  place_design 
  write_checkpoint -force alinx_ov5640_placed.dcp
  report_io -file alinx_ov5640_io_placed.rpt
  report_utilization -file alinx_ov5640_utilization_placed.rpt -pb alinx_ov5640_utilization_placed.pb
  report_control_sets -verbose -file alinx_ov5640_control_sets_placed.rpt
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
}

start_step route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force alinx_ov5640_routed.dcp
  report_drc -file alinx_ov5640_drc_routed.rpt -pb alinx_ov5640_drc_routed.pb
  report_timing_summary -warn_on_violation -max_paths 10 -file alinx_ov5640_timing_summary_routed.rpt -rpx alinx_ov5640_timing_summary_routed.rpx
  report_power -file alinx_ov5640_power_routed.rpt -pb alinx_ov5640_power_summary_routed.pb
  report_route_status -file alinx_ov5640_route_status.rpt -pb alinx_ov5640_route_status.pb
  report_clock_utilization -file alinx_ov5640_clock_utilization_routed.rpt
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
}

start_step write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  catch { write_mem_info -force alinx_ov5640.mmi }
  write_bitstream -force alinx_ov5640.bit 
  catch { write_sysdef -hwdef alinx_ov5640.hwdef -bitfile alinx_ov5640.bit -meminfo alinx_ov5640.mmi -file alinx_ov5640.sysdef }
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
}

