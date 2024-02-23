set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]
############## clock define##################
create_clock -period 5.000 [get_ports sys_clk_p]
set_property PACKAGE_PIN C8 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]

set_property PACKAGE_PIN K15 [get_ports vout_clk]
set_property PACKAGE_PIN H13 [get_ports {vout_data[0]}]
set_property PACKAGE_PIN E11 [get_ports {vout_data[1]}]
set_property PACKAGE_PIN D11 [get_ports {vout_data[2]}]
set_property PACKAGE_PIN G11 [get_ports {vout_data[3]}]
set_property PACKAGE_PIN G12 [get_ports {vout_data[4]}]
set_property PACKAGE_PIN K13 [get_ports {vout_data[5]}]
set_property PACKAGE_PIN J13 [get_ports {vout_data[6]}]
set_property PACKAGE_PIN J14 [get_ports {vout_data[7]}]
set_property PACKAGE_PIN H14 [get_ports {vout_data[8]}]
set_property PACKAGE_PIN J15 [get_ports {vout_data[9]}]
set_property PACKAGE_PIN E12 [get_ports {vout_data[10]}]
set_property PACKAGE_PIN F12 [get_ports {vout_data[11]}]
set_property PACKAGE_PIN B15 [get_ports {vout_data[12]}]
set_property PACKAGE_PIN B16 [get_ports {vout_data[13]}]
set_property PACKAGE_PIN B14 [get_ports {vout_data[14]}]
set_property PACKAGE_PIN C14 [get_ports {vout_data[15]}]
set_property PACKAGE_PIN G15 [get_ports {vout_data[16]}]
set_property PACKAGE_PIN G16 [get_ports {vout_data[17]}]
set_property PACKAGE_PIN D14 [get_ports {vout_data[18]}]
set_property PACKAGE_PIN D15 [get_ports {vout_data[19]}]
set_property PACKAGE_PIN D16 [get_ports {vout_data[20]}]
set_property PACKAGE_PIN E16 [get_ports {vout_data[21]}]
set_property PACKAGE_PIN C17 [get_ports {vout_data[22]}]
set_property PACKAGE_PIN C16 [get_ports {vout_data[23]}]
set_property PACKAGE_PIN H12 [get_ports vout_de]
set_property PACKAGE_PIN F10 [get_ports vout_hs]
set_property PACKAGE_PIN G10 [get_ports vout_vs]
set_property PACKAGE_PIN B17 [get_ports hdmi_scl]
set_property PACKAGE_PIN A17 [get_ports hdmi_sda]


set_property IOSTANDARD LVCMOS18 [get_ports vout_clk]
set_property IOSTANDARD LVCMOS18 [get_ports {vout_data[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports vout_de]
set_property IOSTANDARD LVCMOS18 [get_ports vout_hs]
set_property IOSTANDARD LVCMOS18 [get_ports vout_vs]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_scl]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_sda]

set_property PULLUP true [get_ports hdmi_scl]
set_property PULLUP true [get_ports hdmi_sda]

set_property IOB TRUE [get_ports {vout_data[*]}]
set_property IOB TRUE [get_ports vout_de]
set_property IOB TRUE [get_ports vout_hs]
set_property IOB TRUE [get_ports vout_vs]

set_property SLEW FAST [get_ports {vout_data[*]}]
set_property SLEW FAST [get_ports vout_de]
set_property SLEW FAST [get_ports vout_hs]
set_property SLEW FAST [get_ports vout_vs]
set_property SLEW FAST [get_ports vout_clk]


set_property PACKAGE_PIN AD23 [get_ports vin_clk]
set_property PACKAGE_PIN AD25 [get_ports {vin_data[0]}]
set_property PACKAGE_PIN AD24 [get_ports {vin_data[1]}]
set_property PACKAGE_PIN AC24 [get_ports {vin_data[2]}]
set_property PACKAGE_PIN AC23 [get_ports {vin_data[3]}]
set_property PACKAGE_PIN AB26 [get_ports {vin_data[4]}]
set_property PACKAGE_PIN AC26 [get_ports {vin_data[5]}]
set_property PACKAGE_PIN AB24 [get_ports {vin_data[6]}]
set_property PACKAGE_PIN AA24 [get_ports {vin_data[7]}]
set_property PACKAGE_PIN AB25 [get_ports {vin_data[8]}]
set_property PACKAGE_PIN AA25 [get_ports {vin_data[9]}]
set_property PACKAGE_PIN AE23 [get_ports {vin_data[10]}]
set_property PACKAGE_PIN AF23 [get_ports {vin_data[11]}]
set_property PACKAGE_PIN AA23 [get_ports {vin_data[12]}]
set_property PACKAGE_PIN AA22 [get_ports {vin_data[13]}]
set_property PACKAGE_PIN AF20 [get_ports {vin_data[14]}]
set_property PACKAGE_PIN AF19 [get_ports {vin_data[15]}]
set_property PACKAGE_PIN W19 [get_ports {vin_data[16]}]
set_property PACKAGE_PIN W18 [get_ports {vin_data[17]}]
set_property PACKAGE_PIN AA19 [get_ports {vin_data[18]}]
set_property PACKAGE_PIN AB19 [get_ports {vin_data[19]}]
set_property PACKAGE_PIN AD19 [get_ports {vin_data[20]}]
set_property PACKAGE_PIN AD18 [get_ports {vin_data[21]}]
set_property PACKAGE_PIN Y20 [get_ports {vin_data[22]}]
set_property PACKAGE_PIN W20 [get_ports {vin_data[23]}]
set_property PACKAGE_PIN AD26 [get_ports vin_de]
set_property PACKAGE_PIN AF24 [get_ports vin_hs]
set_property PACKAGE_PIN AA18 [get_ports hdmi_in_nreset]
set_property PACKAGE_PIN AF25 [get_ports vin_vs]
set_property PACKAGE_PIN AE26 [get_ports vin_scl]
set_property PACKAGE_PIN AE25 [get_ports vin_sda]

set_property PULLUP true [get_ports vin_scl]
set_property PULLUP true [get_ports vin_sda]

set_property IOSTANDARD LVCMOS33 [get_ports vin_clk]
set_property IOSTANDARD LVCMOS33 [get_ports {vin_data[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports vin_de]
set_property IOSTANDARD LVCMOS33 [get_ports vin_hs]
set_property IOSTANDARD LVCMOS33 [get_ports vin_vs]
set_property IOSTANDARD LVCMOS33 [get_ports hdmi_in_nreset]
set_property IOSTANDARD LVCMOS33 [get_ports vin_scl]
set_property IOSTANDARD LVCMOS33 [get_ports vin_sda]

set_property IOB TRUE [get_ports {vin_data[*]}]
set_property IOB TRUE [get_ports vin_de]
set_property IOB TRUE [get_ports vin_hs]
set_property IOB TRUE [get_ports vin_vs]

#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets vout_clk_OBUF]


set_property DRIVE 12 [get_ports {vout_data[*]}]
set_property DRIVE 16 [get_ports vout_clk]
set_property DRIVE 12 [get_ports vout_de]
set_property DRIVE 12 [get_ports vout_hs]

create_clock -period 6.734 -name vin_clk -waveform {0.000 3.367} [get_ports vin_clk]
set_input_delay -clock [get_clocks vin_clk] -min -add_delay 1.010 [get_ports {vin_data[*]}]
set_input_delay -clock [get_clocks vin_clk] -max -add_delay 2.500 [get_ports {vin_data[*]}]
set_input_delay -clock [get_clocks vin_clk] -min -add_delay 1.010 [get_ports vin_de]
set_input_delay -clock [get_clocks vin_clk] -max -add_delay 2.500 [get_ports vin_de]
set_input_delay -clock [get_clocks vin_clk] -min -add_delay 1.010 [get_ports vin_hs]
set_input_delay -clock [get_clocks vin_clk] -max -add_delay 2.500 [get_ports vin_hs]
set_input_delay -clock [get_clocks vin_clk] -min -add_delay 1.010 [get_ports vin_vs]
set_input_delay -clock [get_clocks vin_clk] -max -add_delay 2.500 [get_ports vin_vs]






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
connect_debug_port u_ila_0/clk [get_nets [list vout_clk_OBUF_BUFG]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 24 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {vin_data_IBUF[0]} {vin_data_IBUF[1]} {vin_data_IBUF[2]} {vin_data_IBUF[3]} {vin_data_IBUF[4]} {vin_data_IBUF[5]} {vin_data_IBUF[6]} {vin_data_IBUF[7]} {vin_data_IBUF[8]} {vin_data_IBUF[9]} {vin_data_IBUF[10]} {vin_data_IBUF[11]} {vin_data_IBUF[12]} {vin_data_IBUF[13]} {vin_data_IBUF[14]} {vin_data_IBUF[15]} {vin_data_IBUF[16]} {vin_data_IBUF[17]} {vin_data_IBUF[18]} {vin_data_IBUF[19]} {vin_data_IBUF[20]} {vin_data_IBUF[21]} {vin_data_IBUF[22]} {vin_data_IBUF[23]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 1 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list vin_de_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 1 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list vin_hs_IBUF]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 1 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list vin_vs_IBUF]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets vout_clk_OBUF_BUFG]
