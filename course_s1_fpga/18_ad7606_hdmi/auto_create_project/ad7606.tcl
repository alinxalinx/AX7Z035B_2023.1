#////////////////////////////////////////////////////////////////////////////////
#  project：AD7606 multi-channel waveform display experiment                   //
#                                                                              //
#  Author: JunFN                                                               //
#          853808728@qq.com                                                    //
#          ALINX(shanghai) Technology Co.,Ltd                                  //
#          黑金                                                                //
#     WEB: http://www.alinx.cn/                                                //
#                                                                              //
#////////////////////////////////////////////////////////////////////////////////
#                                                                              //
# Copyright (c) 2017,ALINX(shanghai) Technology Co.,Ltd                        //
#                    All rights reserved                                       //
#                                                                              //
# This source file may be used and distributed without restriction provided    //
# that this copyright statement is not removed from the file and that any      //
# derivative work contains the original copyright notice and the associated    //
# disclaimer.                                                                  //
#                                                                              // 
#////////////////////////////////////////////////////////////////////////////////

#================================================================================
#  Revision History:
#  Date          By            Revision    Change Description
# --------------------------------------------------------------------------------
#  2023/8/22                   1.0          Original
#=================================================================================

#设置项目名称和工作目录
set projname "vivado_ad7606"
set Topname "top"
set tclpath [pwd]
cd ..
set projpath [pwd]
#创建工程
#**********************************************************************************************************
create_project -force $projname $projpath/$projname -part xc7z035ffg676-2
# Create 'sources_1' fileset (if not found)
if {[string equal [get_filesets -quiet sources_1] ""]} {
  create_fileset -srcset sources_1
}
file mkdir $projpath/$projname/$projname.srcs/sources_1/ip
file mkdir $projpath/$projname/$projname.srcs/sources_1/new
file mkdir $projpath/$projname/$projname.srcs/sources_1/bd
# Create 'constrs_1' fileset (if not found)
if {[string equal [get_filesets -quiet constrs_1] ""]} {
  create_fileset -constrset constrs_1
}
file mkdir $projpath/$projname/$projname.srcs/constrs_1/new
# Create 'sim_1' fileset (if not found)
if {[string equal [get_filesets -quiet sim_1] ""]} {
  create_fileset -simset sim_1
}
file mkdir $projpath/$projname/$projname.srcs/sim_1/new
#*********************************************************************************************************
# 添加IP
create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name adc_pll
set_property -dict [list \
  CONFIG.CLKIN1_JITTER_PS {50.0} \
  CONFIG.CLKOUT1_JITTER {112.316} \
  CONFIG.CLKOUT1_PHASE_ERROR {89.971} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {5.000} \
  CONFIG.MMCM_CLKIN1_PERIOD {5.000} \
  CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
  CONFIG.PRIM_IN_FREQ {200} \
  CONFIG.PRIM_SOURCE {No_buffer} \
] [get_ips adc_pll]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/adc_pll/adc_pll.xci]

create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name video_pll
set_property -dict [list \
  CONFIG.CLKIN1_JITTER_PS {50.0} \
  CONFIG.CLKOUT1_JITTER {242.214} \
  CONFIG.CLKOUT1_PHASE_ERROR {245.344} \
  CONFIG.CLKOUT1_REQUESTED_OUT_FREQ {74.25} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {37.125} \
  CONFIG.MMCM_CLKIN1_PERIOD {5.000} \
  CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
  CONFIG.MMCM_CLKOUT0_DIVIDE_F {12.500} \
  CONFIG.MMCM_DIVCLK_DIVIDE {8} \
  CONFIG.PRIM_IN_FREQ {200} \
  CONFIG.PRIM_SOURCE {No_buffer} \
] [get_ips video_pll]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/video_pll/video_pll.xci]

create_ip -name blk_mem_gen -vendor xilinx.com -library ip -version 8.4 -module_name dpram2048x8
set_property -dict [list \
  CONFIG.Memory_Type {Simple_Dual_Port_RAM} \
  CONFIG.Register_PortB_Output_of_Memory_Primitives {false} \
  CONFIG.Write_Depth_A {2048} \
  CONFIG.Write_Width_A {8} \
] [get_ips dpram2048x8]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/dpram2048x8/dpram2048x8.xci]
#*********************************************************************************************************
#添加源文件
add_files -fileset sources_1  -copy_to $projpath/$projname/$projname.srcs/sources_1/new -force -quiet [glob -nocomplain $tclpath/src/design/*.v]
add_files -fileset sources_1  -copy_to $projpath/$projname/$projname.srcs/sources_1/new -force -quiet [glob -nocomplain $tclpath/src/design/i2c_master/*.v]
#添加约束文件
add_files -fileset constrs_1  -copy_to $projpath/$projname/$projname.srcs/constrs_1/new -force -quiet [glob -nocomplain $tclpath/src/constraints/*.xdc]
#**********************************************************************************************************
set_property top_file "/$projpath/$projname/$projname.srcs/sources_1/new/$Topname.v" [current_fileset]
launch_runs synth_1 impl_1 -jobs 5
wait_on_run synth_1
wait_on_run impl_1
synth_design -top $Topname
opt_design
place_design
route_design
write_bitstream -force $projpath/$projname/$projname.runs/impl_1/$projname.bit
add_files -fileset sources_1  -copy_to $projpath -force -quiet [glob -nocomplain $projpath/$projname/$projname.runs/impl_1/*.bit]