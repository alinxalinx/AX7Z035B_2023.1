#////////////////////////////////////////////////////////////////////////////////
#  project：FPGA on-chip FIFO read and write test experiment                   //
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
set projname "gtx_1g"
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
# 添加IP
create_ip -name gtwizard -vendor xilinx.com -library ip -version 3.6 -module_name gtx
set_property -dict [list \
  CONFIG.advanced_clocking {false} \
  CONFIG.gt0_val_align_comma_double {false} \
  CONFIG.gt0_val_align_comma_enable {1111111111} \
  CONFIG.gt0_val_align_comma_word {Two_Byte_Boundaries} \
  CONFIG.gt0_val_align_mcomma_det {true} \
  CONFIG.gt0_val_align_mcomma_value {1010000011} \
  CONFIG.gt0_val_align_pcomma_det {true} \
  CONFIG.gt0_val_align_pcomma_value {0101111100} \
  CONFIG.gt0_val_cb {false} \
  CONFIG.gt0_val_cc {true} \
  CONFIG.gt0_val_cc_seq_periodicity {5000} \
  CONFIG.gt0_val_clk_cor_seq_1_1 {11110111} \
  CONFIG.gt0_val_clk_cor_seq_1_1_disp {false} \
  CONFIG.gt0_val_clk_cor_seq_1_1_k {true} \
  CONFIG.gt0_val_clk_cor_seq_1_1_mask {false} \
  CONFIG.gt0_val_clk_cor_seq_1_2 {11110111} \
  CONFIG.gt0_val_clk_cor_seq_1_2_disp {false} \
  CONFIG.gt0_val_clk_cor_seq_1_2_k {true} \
  CONFIG.gt0_val_clk_cor_seq_1_2_mask {false} \
  CONFIG.gt0_val_clk_cor_seq_1_3 {11110111} \
  CONFIG.gt0_val_clk_cor_seq_1_3_disp {false} \
  CONFIG.gt0_val_clk_cor_seq_1_3_k {true} \
  CONFIG.gt0_val_clk_cor_seq_1_3_mask {false} \
  CONFIG.gt0_val_clk_cor_seq_1_4 {11110111} \
  CONFIG.gt0_val_clk_cor_seq_1_4_disp {false} \
  CONFIG.gt0_val_clk_cor_seq_1_4_k {true} \
  CONFIG.gt0_val_clk_cor_seq_1_4_mask {false} \
  CONFIG.gt0_val_clk_cor_seq_2_1 {00000000} \
  CONFIG.gt0_val_clk_cor_seq_2_2 {00000000} \
  CONFIG.gt0_val_clk_cor_seq_2_3 {00000000} \
  CONFIG.gt0_val_clk_cor_seq_2_4 {00000000} \
  CONFIG.gt0_val_clk_cor_seq_2_use {false} \
  CONFIG.gt0_val_clk_cor_seq_len {4} \
  CONFIG.gt0_val_comma_preset {K28.5} \
  CONFIG.gt0_val_cpll_fbdiv {4} \
  CONFIG.gt0_val_cpll_fbdiv_45 {5} \
  CONFIG.gt0_val_cpll_refclk_div {1} \
  CONFIG.gt0_val_cpll_rxout_div {4} \
  CONFIG.gt0_val_cpll_txout_div {4} \
  CONFIG.gt0_val_dec_valid_comma_only {false} \
  CONFIG.gt0_val_decoding {8B/10B} \
  CONFIG.gt0_val_dfe_mode {LPM-Auto} \
  CONFIG.gt0_val_drp {true} \
  CONFIG.gt0_val_drp_clock {100} \
  CONFIG.gt0_val_encoding {8B/10B} \
  CONFIG.gt0_val_max_cb_level {7} \
  CONFIG.gt0_val_no_rx {false} \
  CONFIG.gt0_val_no_tx {false} \
  CONFIG.gt0_val_pcs_pcie_en {false} \
  CONFIG.gt0_val_pd_trans_time_from_p2 {60} \
  CONFIG.gt0_val_pd_trans_time_non_p2 {25} \
  CONFIG.gt0_val_pd_trans_time_to_p2 {100} \
  CONFIG.gt0_val_port_cominitdet {false} \
  CONFIG.gt0_val_port_comsasdet {false} \
  CONFIG.gt0_val_port_comwakedet {false} \
  CONFIG.gt0_val_port_loopback {true} \
  CONFIG.gt0_val_port_phystatus {false} \
  CONFIG.gt0_val_port_rxbufreset {true} \
  CONFIG.gt0_val_port_rxbufstatus {true} \
  CONFIG.gt0_val_port_rxbyteisaligned {true} \
  CONFIG.gt0_val_port_rxbyterealign {true} \
  CONFIG.gt0_val_port_rxcdrhold {true} \
  CONFIG.gt0_val_port_rxchariscomma {true} \
  CONFIG.gt0_val_port_rxcharisk {true} \
  CONFIG.gt0_val_port_rxcommadet {true} \
  CONFIG.gt0_val_port_rxlpmen {true} \
  CONFIG.gt0_val_port_rxmcommaalignen {true} \
  CONFIG.gt0_val_port_rxpcommaalignen {true} \
  CONFIG.gt0_val_port_rxpcsreset {true} \
  CONFIG.gt0_val_port_rxpmareset {true} \
  CONFIG.gt0_val_port_rxpolarity {true} \
  CONFIG.gt0_val_port_rxpowerdown {true} \
  CONFIG.gt0_val_port_rxrate {false} \
  CONFIG.gt0_val_port_rxslide {false} \
  CONFIG.gt0_val_port_rxstatus {false} \
  CONFIG.gt0_val_port_rxvalid {false} \
  CONFIG.gt0_val_port_tx8b10bbypass {false} \
  CONFIG.gt0_val_port_txbufstatus {true} \
  CONFIG.gt0_val_port_txchardispmode {true} \
  CONFIG.gt0_val_port_txchardispval {true} \
  CONFIG.gt0_val_port_txcomfinish {false} \
  CONFIG.gt0_val_port_txcominit {false} \
  CONFIG.gt0_val_port_txcomsas {false} \
  CONFIG.gt0_val_port_txcomwake {false} \
  CONFIG.gt0_val_port_txdetectrx {false} \
  CONFIG.gt0_val_port_txelecidle {false} \
  CONFIG.gt0_val_port_txinhibit {false} \
  CONFIG.gt0_val_port_txpcsreset {true} \
  CONFIG.gt0_val_port_txpmareset {true} \
  CONFIG.gt0_val_port_txpolarity {true} \
  CONFIG.gt0_val_port_txpowerdown {true} \
  CONFIG.gt0_val_port_txprbsforceerr {true} \
  CONFIG.gt0_val_port_txprbssel {true} \
  CONFIG.gt0_val_port_txrate {false} \
  CONFIG.gt0_val_ppm_offset {100} \
  CONFIG.gt0_val_prbs_detector {true} \
  CONFIG.gt0_val_protocol_file {aurora_8b10b_single_lane_4byte} \
  CONFIG.gt0_val_qpll_fbdiv {40} \
  CONFIG.gt0_val_qpll_refclk_div {1} \
  CONFIG.gt0_val_rx_buffer_bypass_mode {Auto} \
  CONFIG.gt0_val_rx_cm_trim {800} \
  CONFIG.gt0_val_rx_data_width {32} \
  CONFIG.gt0_val_rx_int_datawidth {20} \
  CONFIG.gt0_val_rx_line_rate {1.25} \
  CONFIG.gt0_val_rx_reference_clock {125.000} \
  CONFIG.gt0_val_rx_termination_voltage {Programmable} \
  CONFIG.gt0_val_rxbuf_en {true} \
  CONFIG.gt0_val_rxprbs_err_loopback {false} \
  CONFIG.gt0_val_rxslide_mode {OFF} \
  CONFIG.gt0_val_rxusrclk {TXOUTCLK} \
  CONFIG.gt0_val_sata_e_idle_val {4} \
  CONFIG.gt0_val_sata_rx_burst_val {4} \
  CONFIG.gt0_val_tx_buffer_bypass_mode {Auto} \
  CONFIG.gt0_val_tx_data_width {32} \
  CONFIG.gt0_val_tx_int_datawidth {20} \
  CONFIG.gt0_val_tx_line_rate {1.25} \
  CONFIG.gt0_val_tx_reference_clock {125.000} \
  CONFIG.gt0_val_txbuf_en {true} \
  CONFIG.gt0_val_txdiffctrl {true} \
  CONFIG.gt0_val_txmaincursor {true} \
  CONFIG.gt0_val_txpostcursor {true} \
  CONFIG.gt0_val_txprecursor {true} \
  CONFIG.gt0_val_txusrclk {TXOUTCLK} \
  CONFIG.gt10_val {true} \
  CONFIG.gt10_val_rx_refclk {REFCLK0_Q2} \
  CONFIG.gt10_val_tx_refclk {REFCLK0_Q2} \
  CONFIG.gt11_val {true} \
  CONFIG.gt11_val_rx_refclk {REFCLK0_Q2} \
  CONFIG.gt11_val_tx_refclk {REFCLK0_Q2} \
  CONFIG.gt12_val {false} \
  CONFIG.gt12_val_rx_refclk {REFCLK1_Q3} \
  CONFIG.gt12_val_tx_refclk {REFCLK1_Q3} \
  CONFIG.gt13_val {false} \
  CONFIG.gt13_val_rx_refclk {REFCLK1_Q3} \
  CONFIG.gt13_val_tx_refclk {REFCLK1_Q3} \
  CONFIG.gt14_val {false} \
  CONFIG.gt14_val_rx_refclk {REFCLK1_Q3} \
  CONFIG.gt14_val_tx_refclk {REFCLK1_Q3} \
  CONFIG.gt15_val {false} \
  CONFIG.gt15_val_rx_refclk {REFCLK1_Q3} \
  CONFIG.gt15_val_tx_refclk {REFCLK1_Q3} \
  CONFIG.gt8_val {true} \
  CONFIG.gt8_val_rx_refclk {REFCLK0_Q2} \
  CONFIG.gt8_val_tx_refclk {REFCLK0_Q2} \
  CONFIG.gt9_val {true} \
  CONFIG.gt9_val_rx_refclk {REFCLK0_Q2} \
  CONFIG.gt9_val_tx_refclk {REFCLK0_Q2} \
  CONFIG.gt_val_drp {false} \
  CONFIG.gt_val_drp_clock {100} \
  CONFIG.gt_val_rx_pll {CPLL} \
  CONFIG.gt_val_tx_pll {CPLL} \
  CONFIG.identical_protocol_file {aurora_8b10b_single_lane_4byte} \
  CONFIG.identical_val_no_rx {false} \
  CONFIG.identical_val_no_tx {false} \
  CONFIG.identical_val_rx_line_rate {1.25} \
  CONFIG.identical_val_rx_reference_clock {125.000} \
  CONFIG.identical_val_tx_line_rate {1.25} \
  CONFIG.identical_val_tx_reference_clock {125.000} \
] [get_ips gtx]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/gtx_1/gtx.xci]
update_compile_order -fileset sources_1

create_ip -name clk_wiz -vendor xilinx.com -library ip -version 6.0 -module_name sys_clock
set_property -dict [list \
  CONFIG.CLKIN1_JITTER_PS {50.0} \
  CONFIG.CLKOUT1_JITTER {112.316} \
  CONFIG.CLKOUT1_PHASE_ERROR {89.971} \
  CONFIG.MMCM_CLKFBOUT_MULT_F {5.000} \
  CONFIG.MMCM_CLKIN1_PERIOD {5.000} \
  CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
  CONFIG.PRIM_IN_FREQ {200} \
  CONFIG.PRIM_SOURCE {No_buffer} \
] [get_ips sys_clock]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/sys_clock/sys_clock.xci]

create_ip -name proc_sys_reset -vendor xilinx.com -library ip -version 5.0 -module_name proc_sys_reset_0
set_property -dict [list \
  CONFIG.C_EXT_RESET_HIGH {0}
] [get_ips proc_sys_reset_0]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/proc_sys_reset_0/proc_sys_reset_0.xci]

create_ip -name ila -vendor xilinx.com -library ip -version 6.2 -module_name ila_0
set_property -dict [list \
  CONFIG.C_DATA_DEPTH {4096} \
  CONFIG.C_NUM_OF_PROBES {6} \
  CONFIG.C_PROBE0_WIDTH {32} \
  CONFIG.C_PROBE1_WIDTH {4} \
  CONFIG.C_PROBE2_WIDTH {32} \
  CONFIG.C_PROBE3_WIDTH {4} \
  CONFIG.C_PROBE4_WIDTH {32} \
  CONFIG.C_PROBE5_WIDTH {32} \
] [get_ips ila_0]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/ila_0/ila_0.xci]
#*********************************************************************************************************
#添加源文件
add_files -fileset sources_1  -copy_to $projpath/$projname/$projname.srcs/sources_1/new -force -quiet [glob -nocomplain $tclpath/src/design/*.v]
add_files -fileset sources_1  -copy_to $projpath/$projname/$projname.srcs/sources_1/new -force -quiet [glob -nocomplain $tclpath/src/design/*.vhd]
#add_files -fileset sources_1  -copy_to $projpath/$projname/$projname.srcs/sources_1/new -force -quiet [glob -nocomplain $tclpath/src/design/*.mif]
add_files -fileset sources_1  -copy_to $projpath/$projname/$projname.srcs/sources_1/new -force -quiet [glob -nocomplain $tclpath/src/design/*.dat]
add_files -fileset sim_1  -copy_to $projpath/$projname/$projname.srcs/sim_1/new -force -quiet [glob -nocomplain $tclpath/src/testbench/*.v]

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
write_bitstream -force $projpath/$projname/$projname.runs/impl_1/$Topname.bit
write_debug_probes -file $projpath/$projname/$projname.runs/impl_1/$Topname.ltx
add_files -fileset sources_1  -copy_to $projpath -force -quiet [glob -nocomplain $projpath/$projname/$projname.runs/impl_1/*.bit]
add_files -fileset sources_1  -copy_to $projpath -force -quiet [glob -nocomplain $projpath/$projname/$projname.runs/impl_1/*.ltx]
