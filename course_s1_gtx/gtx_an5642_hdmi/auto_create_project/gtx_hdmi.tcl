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
set projname "gtx_hdmi"
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
  CONFIG.gt0_val_cpll_fbdiv {5} \
  CONFIG.gt0_val_cpll_fbdiv_45 {5} \
  CONFIG.gt0_val_cpll_refclk_div {1} \
  CONFIG.gt0_val_cpll_rxout_div {2} \
  CONFIG.gt0_val_cpll_txout_div {2} \
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
  CONFIG.gt0_val_rx_line_rate {3.125} \
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
  CONFIG.gt0_val_tx_line_rate {3.125} \
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
  CONFIG.identical_val_rx_line_rate {3.125} \
  CONFIG.identical_val_rx_reference_clock {125.000} \
  CONFIG.identical_val_tx_line_rate {3.125} \
  CONFIG.identical_val_tx_reference_clock {125.000} \
] [get_ips gtx]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/gtx_1/gtx.xci]
update_compile_order -fileset sources_1

create_ip -name mig_7series -vendor xilinx.com -library ip -version 4.2 -module_name ddr3
set_property -dict [list \
  CONFIG.ARESETN.INSERT_VIP {0} \
  CONFIG.BOARD_MIG_PARAM {Custom} \
  CONFIG.C0_ARESETN.INSERT_VIP {0} \
  CONFIG.C0_CLOCK.INSERT_VIP {0} \
  CONFIG.C0_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C0_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C0_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C0_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C0_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C0_RESET.INSERT_VIP {0} \
  CONFIG.C0_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C0_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C0_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C1_ARESETN.INSERT_VIP {0} \
  CONFIG.C1_CLOCK.INSERT_VIP {0} \
  CONFIG.C1_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C1_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C1_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C1_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C1_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C1_RESET.INSERT_VIP {0} \
  CONFIG.C1_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C1_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C1_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C2_ARESETN.INSERT_VIP {0} \
  CONFIG.C2_CLOCK.INSERT_VIP {0} \
  CONFIG.C2_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C2_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C2_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C2_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C2_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C2_RESET.INSERT_VIP {0} \
  CONFIG.C2_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C2_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C2_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C3_ARESETN.INSERT_VIP {0} \
  CONFIG.C3_CLOCK.INSERT_VIP {0} \
  CONFIG.C3_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C3_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C3_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C3_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C3_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C3_RESET.INSERT_VIP {0} \
  CONFIG.C3_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C3_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C3_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C4_ARESETN.INSERT_VIP {0} \
  CONFIG.C4_CLOCK.INSERT_VIP {0} \
  CONFIG.C4_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C4_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C4_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C4_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C4_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C4_RESET.INSERT_VIP {0} \
  CONFIG.C4_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C4_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C4_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C5_ARESETN.INSERT_VIP {0} \
  CONFIG.C5_CLOCK.INSERT_VIP {0} \
  CONFIG.C5_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C5_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C5_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C5_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C5_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C5_RESET.INSERT_VIP {0} \
  CONFIG.C5_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C5_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C5_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C6_ARESETN.INSERT_VIP {0} \
  CONFIG.C6_CLOCK.INSERT_VIP {0} \
  CONFIG.C6_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C6_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C6_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C6_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C6_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C6_RESET.INSERT_VIP {0} \
  CONFIG.C6_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C6_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C6_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.C7_ARESETN.INSERT_VIP {0} \
  CONFIG.C7_CLOCK.INSERT_VIP {0} \
  CONFIG.C7_DDR2_RESET.INSERT_VIP {0} \
  CONFIG.C7_DDR3_RESET.INSERT_VIP {0} \
  CONFIG.C7_LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.C7_MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.C7_QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.C7_RESET.INSERT_VIP {0} \
  CONFIG.C7_RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.C7_RLDII_RESET.INSERT_VIP {0} \
  CONFIG.C7_SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.CLK_REF_I.INSERT_VIP {0} \
  CONFIG.CLOCK.INSERT_VIP {0} \
  CONFIG.DDR2_RESET.INSERT_VIP {0} \
  CONFIG.DDR3_RESET.INSERT_VIP {0} \
  CONFIG.LPDDR2_RESET.INSERT_VIP {0} \
  CONFIG.MIG_DONT_TOUCH_PARAM {Custom} \
  CONFIG.MMCM_CLKOUT0.INSERT_VIP {0} \
  CONFIG.MMCM_CLKOUT1.INSERT_VIP {0} \
  CONFIG.MMCM_CLKOUT2.INSERT_VIP {0} \
  CONFIG.MMCM_CLKOUT3.INSERT_VIP {0} \
  CONFIG.MMCM_CLKOUT4.INSERT_VIP {0} \
  CONFIG.QDRIIP_RESET.INSERT_VIP {0} \
  CONFIG.RESET.INSERT_VIP {0} \
  CONFIG.RESET_BOARD_INTERFACE {Custom} \
  CONFIG.RLDIII_RESET.INSERT_VIP {0} \
  CONFIG.RLDII_RESET.INSERT_VIP {0} \
  CONFIG.S0_AXI.INSERT_VIP {0} \
  CONFIG.S0_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S1_AXI.INSERT_VIP {0} \
  CONFIG.S1_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S2_AXI.INSERT_VIP {0} \
  CONFIG.S2_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S3_AXI.INSERT_VIP {0} \
  CONFIG.S3_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S4_AXI.INSERT_VIP {0} \
  CONFIG.S4_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S5_AXI.INSERT_VIP {0} \
  CONFIG.S5_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S6_AXI.INSERT_VIP {0} \
  CONFIG.S6_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.S7_AXI.INSERT_VIP {0} \
  CONFIG.S7_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.SYSTEM_RESET.INSERT_VIP {0} \
  CONFIG.SYS_CLK_I.INSERT_VIP {0} \
  CONFIG.S_AXI.INSERT_VIP {0} \
  CONFIG.S_AXI_CTRL.INSERT_VIP {0} \
  CONFIG.XML_INPUT_FILE $projpath/mig_a.prj \
] [get_ips ddr3]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/ddr3/ddr3.xci]

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

create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name afifo_16i_64o_512
set_property -dict [list \
  CONFIG.Enable_Safety_Circuit {false} \
  CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM} \
  CONFIG.Input_Data_Width {16} \
  CONFIG.Input_Depth {512} \
  CONFIG.Output_Data_Width {64} \
  CONFIG.Read_Data_Count {true} \
  CONFIG.Write_Data_Count {true} \
] [get_ips afifo_16i_64o_512]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/afifo_16i_64o_512/afifo_16i_64o_512.xci]

create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name afifo_64i_16o_128
set_property -dict [list \
  CONFIG.Enable_Safety_Circuit {false} \
  CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM} \
  CONFIG.Input_Data_Width {64} \
  CONFIG.Input_Depth {128} \
  CONFIG.Output_Data_Width {16} \
  CONFIG.Read_Data_Count {true} \
  CONFIG.Write_Data_Count {true} \
] [get_ips afifo_64i_16o_128]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/afifo_64i_16o_128/afifo_64i_16o_128.xci]

create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name fifo_4096_16i_32o
set_property -dict [list \
  CONFIG.Almost_Empty_Flag {true} \
  CONFIG.Almost_Full_Flag {true} \
  CONFIG.Enable_Safety_Circuit {false} \
  CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM} \
  CONFIG.Input_Data_Width {16} \
  CONFIG.Input_Depth {4096} \
  CONFIG.Output_Data_Width {32} \
  CONFIG.Read_Data_Count {true} \
  CONFIG.Write_Data_Count {true} \
] [get_ips fifo_4096_16i_32o]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/fifo_4096_16i_32o/fifo_4096_16i_32o.xci]

create_ip -name fifo_generator -vendor xilinx.com -library ip -version 13.2 -module_name fifo_2048_32i_8o
set_property -dict [list \
  CONFIG.Almost_Empty_Flag {true} \
  CONFIG.Almost_Full_Flag {true} \
  CONFIG.Enable_Safety_Circuit {false} \
  CONFIG.Fifo_Implementation {Independent_Clocks_Block_RAM} \
  CONFIG.Input_Data_Width {32} \
  CONFIG.Input_Depth {2048} \
  CONFIG.Output_Data_Width {16} \
  CONFIG.Read_Data_Count {true} \
  CONFIG.Write_Data_Count {true} \
] [get_ips fifo_2048_32i_8o]
generate_target {instantiation_template} [get_files $projpath/$projname/$projname.srcs/sources_1/ip/fifo_2048_32i_8o/fifo_2048_32i_8o.xci]
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