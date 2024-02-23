set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN Pullup [current_design]
set_property CFGBVS VCCO [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
############# clock define################################
create_clock -period 5.000 [get_ports sys_clk_p]
set_property PACKAGE_PIN C8 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]
############## key define##################
set_property PACKAGE_PIN AF15 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
set_property PACKAGE_PIN AF14 [get_ports key]
set_property IOSTANDARD LVCMOS33 [get_ports key]
############## fan define##################
set_property IOSTANDARD LVCMOS33 [get_ports fan_pwm]
set_property PACKAGE_PIN Y15 [get_ports fan_pwm]


create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list cmos1_pclk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {cmos1_d_16bit[0]} {cmos1_d_16bit[1]} {cmos1_d_16bit[2]} {cmos1_d_16bit[3]} {cmos1_d_16bit[4]} {cmos1_d_16bit[5]} {cmos1_d_16bit[6]} {cmos1_d_16bit[7]} {cmos1_d_16bit[8]} {cmos1_d_16bit[9]} {cmos1_d_16bit[10]} {cmos1_d_16bit[11]} {cmos1_d_16bit[12]} {cmos1_d_16bit[13]} {cmos1_d_16bit[14]} {cmos1_d_16bit[15]}]]
create_debug_core u_ila_1 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_1]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_1]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_1]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_1]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_1]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_1]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_1]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_1]
set_property port_width 1 [get_debug_ports u_ila_1/clk]
connect_debug_port u_ila_1/clk [get_nets [list cmos2_pclk_IBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe0]
set_property port_width 16 [get_debug_ports u_ila_1/probe0]
connect_debug_port u_ila_1/probe0 [get_nets [list {cmos2_d_16bit[0]} {cmos2_d_16bit[1]} {cmos2_d_16bit[2]} {cmos2_d_16bit[3]} {cmos2_d_16bit[4]} {cmos2_d_16bit[5]} {cmos2_d_16bit[6]} {cmos2_d_16bit[7]} {cmos2_d_16bit[8]} {cmos2_d_16bit[9]} {cmos2_d_16bit[10]} {cmos2_d_16bit[11]} {cmos2_d_16bit[12]} {cmos2_d_16bit[13]} {cmos2_d_16bit[14]} {cmos2_d_16bit[15]}]]
create_debug_core u_ila_2 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_2]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_2]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_2]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_2]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_2]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_2]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_2]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_2]
set_property port_width 1 [get_debug_ports u_ila_2/clk]
connect_debug_port u_ila_2/clk [get_nets [list gtx_exdes_m0/gtx_support_i/gt_usrclk_source/txoutclk_mmcm0_i/CLK0_OUT]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe0]
set_property port_width 32 [get_debug_ports u_ila_2/probe0]
connect_debug_port u_ila_2/probe0 [get_nets [list {rx2_data[0]} {rx2_data[1]} {rx2_data[2]} {rx2_data[3]} {rx2_data[4]} {rx2_data[5]} {rx2_data[6]} {rx2_data[7]} {rx2_data[8]} {rx2_data[9]} {rx2_data[10]} {rx2_data[11]} {rx2_data[12]} {rx2_data[13]} {rx2_data[14]} {rx2_data[15]} {rx2_data[16]} {rx2_data[17]} {rx2_data[18]} {rx2_data[19]} {rx2_data[20]} {rx2_data[21]} {rx2_data[22]} {rx2_data[23]} {rx2_data[24]} {rx2_data[25]} {rx2_data[26]} {rx2_data[27]} {rx2_data[28]} {rx2_data[29]} {rx2_data[30]} {rx2_data[31]}]]
create_debug_core u_ila_3 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_3]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_3]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_3]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_3]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_3]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_3]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_3]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_3]
set_property port_width 1 [get_debug_ports u_ila_3/clk]
connect_debug_port u_ila_3/clk [get_nets [list u_ddr3/u_ddr3_mig/u_ddr3_infrastructure/CLK]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe0]
set_property port_width 32 [get_debug_ports u_ila_3/probe0]
connect_debug_port u_ila_3/probe0 [get_nets [list {rd_burst_data[0]} {rd_burst_data[1]} {rd_burst_data[2]} {rd_burst_data[3]} {rd_burst_data[4]} {rd_burst_data[5]} {rd_burst_data[6]} {rd_burst_data[7]} {rd_burst_data[8]} {rd_burst_data[9]} {rd_burst_data[10]} {rd_burst_data[11]} {rd_burst_data[12]} {rd_burst_data[13]} {rd_burst_data[14]} {rd_burst_data[15]} {rd_burst_data[16]} {rd_burst_data[17]} {rd_burst_data[18]} {rd_burst_data[19]} {rd_burst_data[20]} {rd_burst_data[21]} {rd_burst_data[22]} {rd_burst_data[23]} {rd_burst_data[24]} {rd_burst_data[25]} {rd_burst_data[26]} {rd_burst_data[27]} {rd_burst_data[28]} {rd_burst_data[29]} {rd_burst_data[30]} {rd_burst_data[31]}]]
create_debug_core u_ila_4 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_4]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_4]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_4]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_4]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_4]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_4]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_4]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_4]
set_property port_width 1 [get_debug_ports u_ila_4/clk]
connect_debug_port u_ila_4/clk [get_nets [list video_pll_m0/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_4/probe0]
set_property port_width 16 [get_debug_ports u_ila_4/probe0]
connect_debug_port u_ila_4/probe0 [get_nets [list {read_data[0]} {read_data[1]} {read_data[2]} {read_data[3]} {read_data[4]} {read_data[5]} {read_data[6]} {read_data[7]} {read_data[8]} {read_data[9]} {read_data[10]} {read_data[11]} {read_data[12]} {read_data[13]} {read_data[14]} {read_data[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list cmos1_href_16bit]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list cmos1_vsync_IBUF]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe1]
set_property port_width 1 [get_debug_ports u_ila_1/probe1]
connect_debug_port u_ila_1/probe1 [get_nets [list cmos2_href_16bit]]
create_debug_port u_ila_1 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_1/probe2]
set_property port_width 1 [get_debug_ports u_ila_1/probe2]
connect_debug_port u_ila_1/probe2 [get_nets [list cmos2_vsync_IBUF]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe1]
set_property port_width 4 [get_debug_ports u_ila_2/probe1]
connect_debug_port u_ila_2/probe1 [get_nets [list {gt_tx_ctrl1[0]} {gt_tx_ctrl1[1]} {gt_tx_ctrl1[2]} {gt_tx_ctrl1[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe2]
set_property port_width 32 [get_debug_ports u_ila_2/probe2]
connect_debug_port u_ila_2/probe2 [get_nets [list {gt_tx_data0[0]} {gt_tx_data0[1]} {gt_tx_data0[2]} {gt_tx_data0[3]} {gt_tx_data0[4]} {gt_tx_data0[5]} {gt_tx_data0[6]} {gt_tx_data0[7]} {gt_tx_data0[8]} {gt_tx_data0[9]} {gt_tx_data0[10]} {gt_tx_data0[11]} {gt_tx_data0[12]} {gt_tx_data0[13]} {gt_tx_data0[14]} {gt_tx_data0[15]} {gt_tx_data0[16]} {gt_tx_data0[17]} {gt_tx_data0[18]} {gt_tx_data0[19]} {gt_tx_data0[20]} {gt_tx_data0[21]} {gt_tx_data0[22]} {gt_tx_data0[23]} {gt_tx_data0[24]} {gt_tx_data0[25]} {gt_tx_data0[26]} {gt_tx_data0[27]} {gt_tx_data0[28]} {gt_tx_data0[29]} {gt_tx_data0[30]} {gt_tx_data0[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe3]
set_property port_width 4 [get_debug_ports u_ila_2/probe3]
connect_debug_port u_ila_2/probe3 [get_nets [list {rx3_kchar[0]} {rx3_kchar[1]} {rx3_kchar[2]} {rx3_kchar[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe4]
set_property port_width 32 [get_debug_ports u_ila_2/probe4]
connect_debug_port u_ila_2/probe4 [get_nets [list {rx0_data[0]} {rx0_data[1]} {rx0_data[2]} {rx0_data[3]} {rx0_data[4]} {rx0_data[5]} {rx0_data[6]} {rx0_data[7]} {rx0_data[8]} {rx0_data[9]} {rx0_data[10]} {rx0_data[11]} {rx0_data[12]} {rx0_data[13]} {rx0_data[14]} {rx0_data[15]} {rx0_data[16]} {rx0_data[17]} {rx0_data[18]} {rx0_data[19]} {rx0_data[20]} {rx0_data[21]} {rx0_data[22]} {rx0_data[23]} {rx0_data[24]} {rx0_data[25]} {rx0_data[26]} {rx0_data[27]} {rx0_data[28]} {rx0_data[29]} {rx0_data[30]} {rx0_data[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe5]
set_property port_width 32 [get_debug_ports u_ila_2/probe5]
connect_debug_port u_ila_2/probe5 [get_nets [list {gt_tx_data1[0]} {gt_tx_data1[1]} {gt_tx_data1[2]} {gt_tx_data1[3]} {gt_tx_data1[4]} {gt_tx_data1[5]} {gt_tx_data1[6]} {gt_tx_data1[7]} {gt_tx_data1[8]} {gt_tx_data1[9]} {gt_tx_data1[10]} {gt_tx_data1[11]} {gt_tx_data1[12]} {gt_tx_data1[13]} {gt_tx_data1[14]} {gt_tx_data1[15]} {gt_tx_data1[16]} {gt_tx_data1[17]} {gt_tx_data1[18]} {gt_tx_data1[19]} {gt_tx_data1[20]} {gt_tx_data1[21]} {gt_tx_data1[22]} {gt_tx_data1[23]} {gt_tx_data1[24]} {gt_tx_data1[25]} {gt_tx_data1[26]} {gt_tx_data1[27]} {gt_tx_data1[28]} {gt_tx_data1[29]} {gt_tx_data1[30]} {gt_tx_data1[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe6]
set_property port_width 4 [get_debug_ports u_ila_2/probe6]
connect_debug_port u_ila_2/probe6 [get_nets [list {rx2_kchar[0]} {rx2_kchar[1]} {rx2_kchar[2]} {rx2_kchar[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe7]
set_property port_width 4 [get_debug_ports u_ila_2/probe7]
connect_debug_port u_ila_2/probe7 [get_nets [list {rx1_kchar[0]} {rx1_kchar[1]} {rx1_kchar[2]} {rx1_kchar[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe8]
set_property port_width 32 [get_debug_ports u_ila_2/probe8]
connect_debug_port u_ila_2/probe8 [get_nets [list {rx3_data[0]} {rx3_data[1]} {rx3_data[2]} {rx3_data[3]} {rx3_data[4]} {rx3_data[5]} {rx3_data[6]} {rx3_data[7]} {rx3_data[8]} {rx3_data[9]} {rx3_data[10]} {rx3_data[11]} {rx3_data[12]} {rx3_data[13]} {rx3_data[14]} {rx3_data[15]} {rx3_data[16]} {rx3_data[17]} {rx3_data[18]} {rx3_data[19]} {rx3_data[20]} {rx3_data[21]} {rx3_data[22]} {rx3_data[23]} {rx3_data[24]} {rx3_data[25]} {rx3_data[26]} {rx3_data[27]} {rx3_data[28]} {rx3_data[29]} {rx3_data[30]} {rx3_data[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe9]
set_property port_width 32 [get_debug_ports u_ila_2/probe9]
connect_debug_port u_ila_2/probe9 [get_nets [list {rx1_data[0]} {rx1_data[1]} {rx1_data[2]} {rx1_data[3]} {rx1_data[4]} {rx1_data[5]} {rx1_data[6]} {rx1_data[7]} {rx1_data[8]} {rx1_data[9]} {rx1_data[10]} {rx1_data[11]} {rx1_data[12]} {rx1_data[13]} {rx1_data[14]} {rx1_data[15]} {rx1_data[16]} {rx1_data[17]} {rx1_data[18]} {rx1_data[19]} {rx1_data[20]} {rx1_data[21]} {rx1_data[22]} {rx1_data[23]} {rx1_data[24]} {rx1_data[25]} {rx1_data[26]} {rx1_data[27]} {rx1_data[28]} {rx1_data[29]} {rx1_data[30]} {rx1_data[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe10]
set_property port_width 4 [get_debug_ports u_ila_2/probe10]
connect_debug_port u_ila_2/probe10 [get_nets [list {rx0_kchar[0]} {rx0_kchar[1]} {rx0_kchar[2]} {rx0_kchar[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe11]
set_property port_width 4 [get_debug_ports u_ila_2/probe11]
connect_debug_port u_ila_2/probe11 [get_nets [list {gt_tx_ctrl0[0]} {gt_tx_ctrl0[1]} {gt_tx_ctrl0[2]} {gt_tx_ctrl0[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe12]
set_property port_width 4 [get_debug_ports u_ila_2/probe12]
connect_debug_port u_ila_2/probe12 [get_nets [list {tx0_kchar[0]} {tx0_kchar[1]} {tx0_kchar[2]} {tx0_kchar[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe13]
set_property port_width 32 [get_debug_ports u_ila_2/probe13]
connect_debug_port u_ila_2/probe13 [get_nets [list {tx0_data[0]} {tx0_data[1]} {tx0_data[2]} {tx0_data[3]} {tx0_data[4]} {tx0_data[5]} {tx0_data[6]} {tx0_data[7]} {tx0_data[8]} {tx0_data[9]} {tx0_data[10]} {tx0_data[11]} {tx0_data[12]} {tx0_data[13]} {tx0_data[14]} {tx0_data[15]} {tx0_data[16]} {tx0_data[17]} {tx0_data[18]} {tx0_data[19]} {tx0_data[20]} {tx0_data[21]} {tx0_data[22]} {tx0_data[23]} {tx0_data[24]} {tx0_data[25]} {tx0_data[26]} {tx0_data[27]} {tx0_data[28]} {tx0_data[29]} {tx0_data[30]} {tx0_data[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe14]
set_property port_width 16 [get_debug_ports u_ila_2/probe14]
connect_debug_port u_ila_2/probe14 [get_nets [list {write_data[0]} {write_data[1]} {write_data[2]} {write_data[3]} {write_data[4]} {write_data[5]} {write_data[6]} {write_data[7]} {write_data[8]} {write_data[9]} {write_data[10]} {write_data[11]} {write_data[12]} {write_data[13]} {write_data[14]} {write_data[15]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe15]
set_property port_width 4 [get_debug_ports u_ila_2/probe15]
connect_debug_port u_ila_2/probe15 [get_nets [list {tx1_kchar[0]} {tx1_kchar[1]} {tx1_kchar[2]} {tx1_kchar[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe16]
set_property port_width 4 [get_debug_ports u_ila_2/probe16]
connect_debug_port u_ila_2/probe16 [get_nets [list {tx2_kchar[0]} {tx2_kchar[1]} {tx2_kchar[2]} {tx2_kchar[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe17]
set_property port_width 4 [get_debug_ports u_ila_2/probe17]
connect_debug_port u_ila_2/probe17 [get_nets [list {tx3_kchar[0]} {tx3_kchar[1]} {tx3_kchar[2]} {tx3_kchar[3]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe18]
set_property port_width 32 [get_debug_ports u_ila_2/probe18]
connect_debug_port u_ila_2/probe18 [get_nets [list {tx2_data[0]} {tx2_data[1]} {tx2_data[2]} {tx2_data[3]} {tx2_data[4]} {tx2_data[5]} {tx2_data[6]} {tx2_data[7]} {tx2_data[8]} {tx2_data[9]} {tx2_data[10]} {tx2_data[11]} {tx2_data[12]} {tx2_data[13]} {tx2_data[14]} {tx2_data[15]} {tx2_data[16]} {tx2_data[17]} {tx2_data[18]} {tx2_data[19]} {tx2_data[20]} {tx2_data[21]} {tx2_data[22]} {tx2_data[23]} {tx2_data[24]} {tx2_data[25]} {tx2_data[26]} {tx2_data[27]} {tx2_data[28]} {tx2_data[29]} {tx2_data[30]} {tx2_data[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe19]
set_property port_width 32 [get_debug_ports u_ila_2/probe19]
connect_debug_port u_ila_2/probe19 [get_nets [list {tx3_data[0]} {tx3_data[1]} {tx3_data[2]} {tx3_data[3]} {tx3_data[4]} {tx3_data[5]} {tx3_data[6]} {tx3_data[7]} {tx3_data[8]} {tx3_data[9]} {tx3_data[10]} {tx3_data[11]} {tx3_data[12]} {tx3_data[13]} {tx3_data[14]} {tx3_data[15]} {tx3_data[16]} {tx3_data[17]} {tx3_data[18]} {tx3_data[19]} {tx3_data[20]} {tx3_data[21]} {tx3_data[22]} {tx3_data[23]} {tx3_data[24]} {tx3_data[25]} {tx3_data[26]} {tx3_data[27]} {tx3_data[28]} {tx3_data[29]} {tx3_data[30]} {tx3_data[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe20]
set_property port_width 32 [get_debug_ports u_ila_2/probe20]
connect_debug_port u_ila_2/probe20 [get_nets [list {tx1_data[0]} {tx1_data[1]} {tx1_data[2]} {tx1_data[3]} {tx1_data[4]} {tx1_data[5]} {tx1_data[6]} {tx1_data[7]} {tx1_data[8]} {tx1_data[9]} {tx1_data[10]} {tx1_data[11]} {tx1_data[12]} {tx1_data[13]} {tx1_data[14]} {tx1_data[15]} {tx1_data[16]} {tx1_data[17]} {tx1_data[18]} {tx1_data[19]} {tx1_data[20]} {tx1_data[21]} {tx1_data[22]} {tx1_data[23]} {tx1_data[24]} {tx1_data[25]} {tx1_data[26]} {tx1_data[27]} {tx1_data[28]} {tx1_data[29]} {tx1_data[30]} {tx1_data[31]}]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe21]
set_property port_width 1 [get_debug_ports u_ila_2/probe21]
connect_debug_port u_ila_2/probe21 [get_nets [list write_en]]
create_debug_port u_ila_2 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_2/probe22]
set_property port_width 1 [get_debug_ports u_ila_2/probe22]
connect_debug_port u_ila_2/probe22 [get_nets [list write_req]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe1]
set_property port_width 25 [get_debug_ports u_ila_3/probe1]
connect_debug_port u_ila_3/probe1 [get_nets [list {rd_burst_addr[0]} {rd_burst_addr[1]} {rd_burst_addr[2]} {rd_burst_addr[3]} {rd_burst_addr[4]} {rd_burst_addr[5]} {rd_burst_addr[6]} {rd_burst_addr[7]} {rd_burst_addr[8]} {rd_burst_addr[9]} {rd_burst_addr[10]} {rd_burst_addr[11]} {rd_burst_addr[12]} {rd_burst_addr[13]} {rd_burst_addr[14]} {rd_burst_addr[15]} {rd_burst_addr[16]} {rd_burst_addr[17]} {rd_burst_addr[18]} {rd_burst_addr[19]} {rd_burst_addr[20]} {rd_burst_addr[21]} {rd_burst_addr[22]} {rd_burst_addr[23]} {rd_burst_addr[24]}]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe2]
set_property port_width 10 [get_debug_ports u_ila_3/probe2]
connect_debug_port u_ila_3/probe2 [get_nets [list {rd_burst_len[0]} {rd_burst_len[1]} {rd_burst_len[2]} {rd_burst_len[3]} {rd_burst_len[4]} {rd_burst_len[5]} {rd_burst_len[6]} {rd_burst_len[7]} {rd_burst_len[8]} {rd_burst_len[9]}]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe3]
set_property port_width 32 [get_debug_ports u_ila_3/probe3]
connect_debug_port u_ila_3/probe3 [get_nets [list {wr_burst_data[0]} {wr_burst_data[1]} {wr_burst_data[2]} {wr_burst_data[3]} {wr_burst_data[4]} {wr_burst_data[5]} {wr_burst_data[6]} {wr_burst_data[7]} {wr_burst_data[8]} {wr_burst_data[9]} {wr_burst_data[10]} {wr_burst_data[11]} {wr_burst_data[12]} {wr_burst_data[13]} {wr_burst_data[14]} {wr_burst_data[15]} {wr_burst_data[16]} {wr_burst_data[17]} {wr_burst_data[18]} {wr_burst_data[19]} {wr_burst_data[20]} {wr_burst_data[21]} {wr_burst_data[22]} {wr_burst_data[23]} {wr_burst_data[24]} {wr_burst_data[25]} {wr_burst_data[26]} {wr_burst_data[27]} {wr_burst_data[28]} {wr_burst_data[29]} {wr_burst_data[30]} {wr_burst_data[31]}]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe4]
set_property port_width 10 [get_debug_ports u_ila_3/probe4]
connect_debug_port u_ila_3/probe4 [get_nets [list {wr_burst_len[0]} {wr_burst_len[1]} {wr_burst_len[2]} {wr_burst_len[3]} {wr_burst_len[4]} {wr_burst_len[5]} {wr_burst_len[6]} {wr_burst_len[7]} {wr_burst_len[8]} {wr_burst_len[9]}]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe5]
set_property port_width 25 [get_debug_ports u_ila_3/probe5]
connect_debug_port u_ila_3/probe5 [get_nets [list {wr_burst_addr[0]} {wr_burst_addr[1]} {wr_burst_addr[2]} {wr_burst_addr[3]} {wr_burst_addr[4]} {wr_burst_addr[5]} {wr_burst_addr[6]} {wr_burst_addr[7]} {wr_burst_addr[8]} {wr_burst_addr[9]} {wr_burst_addr[10]} {wr_burst_addr[11]} {wr_burst_addr[12]} {wr_burst_addr[13]} {wr_burst_addr[14]} {wr_burst_addr[15]} {wr_burst_addr[16]} {wr_burst_addr[17]} {wr_burst_addr[18]} {wr_burst_addr[19]} {wr_burst_addr[20]} {wr_burst_addr[21]} {wr_burst_addr[22]} {wr_burst_addr[23]} {wr_burst_addr[24]}]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe6]
set_property port_width 1 [get_debug_ports u_ila_3/probe6]
connect_debug_port u_ila_3/probe6 [get_nets [list gt0_txfsmresetdone]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe7]
set_property port_width 1 [get_debug_ports u_ila_3/probe7]
connect_debug_port u_ila_3/probe7 [get_nets [list rd_burst_data_valid]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe8]
set_property port_width 1 [get_debug_ports u_ila_3/probe8]
connect_debug_port u_ila_3/probe8 [get_nets [list rd_burst_finish]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe9]
set_property port_width 1 [get_debug_ports u_ila_3/probe9]
connect_debug_port u_ila_3/probe9 [get_nets [list rd_burst_req]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe10]
set_property port_width 1 [get_debug_ports u_ila_3/probe10]
connect_debug_port u_ila_3/probe10 [get_nets [list read_req_ack]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe11]
set_property port_width 1 [get_debug_ports u_ila_3/probe11]
connect_debug_port u_ila_3/probe11 [get_nets [list wr_burst_data_req]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe12]
set_property port_width 1 [get_debug_ports u_ila_3/probe12]
connect_debug_port u_ila_3/probe12 [get_nets [list wr_burst_finish]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe13]
set_property port_width 1 [get_debug_ports u_ila_3/probe13]
connect_debug_port u_ila_3/probe13 [get_nets [list wr_burst_req]]
create_debug_port u_ila_3 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_3/probe14]
set_property port_width 1 [get_debug_ports u_ila_3/probe14]
connect_debug_port u_ila_3/probe14 [get_nets [list write_req_ack]]
create_debug_port u_ila_4 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_4/probe1]
set_property port_width 1 [get_debug_ports u_ila_4/probe1]
connect_debug_port u_ila_4/probe1 [get_nets [list read_en]]
create_debug_port u_ila_4 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_4/probe2]
set_property port_width 1 [get_debug_ports u_ila_4/probe2]
connect_debug_port u_ila_4/probe2 [get_nets [list read_req]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets hdmi_out_clk_OBUF]
