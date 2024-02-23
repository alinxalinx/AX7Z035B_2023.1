set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

set_property PACKAGE_PIN AF15 [get_ports key_tri_i]
set_property IOSTANDARD LVCMOS33 [get_ports key_tri_i]

set_property PACKAGE_PIN AC11 [get_ports dac_clk]
set_property PACKAGE_PIN AB12 [get_ports {dac_data[7]}]
set_property PACKAGE_PIN AA12 [get_ports {dac_data[6]}]
set_property PACKAGE_PIN AA13 [get_ports {dac_data[5]}]
set_property PACKAGE_PIN AF10 [get_ports {dac_data[4]}]
set_property PACKAGE_PIN AE11 [get_ports {dac_data[3]}]
set_property PACKAGE_PIN AC13 [get_ports {dac_data[2]}]
set_property PACKAGE_PIN AD13 [get_ports {dac_data[1]}]
set_property PACKAGE_PIN Y13	 [get_ports {dac_data[0]}]

set_property IOSTANDARD LVCMOS33 [get_ports dac_clk]
set_property IOSTANDARD LVCMOS33 [get_ports {dac_data[*]}]


set_false_path -reset_path -from [get_pins top_i/ad9708_send_0/inst/ad9708_send_v1_0_S00_AXI_inst/send_inst/st_clr_reg/C] -to [get_pins top_i/ad9708_send_0/inst/ad9708_send_v1_0_S00_AXI_inst/st_clr_d0_reg/D]
set_false_path -reset_path -from [get_pins {top_i/ad9708_send_0/inst/ad9708_send_v1_0_S00_AXI_inst/slv_reg0_reg[0]/C}] -to [get_pins top_i/ad9708_send_0/inst/ad9708_send_v1_0_S00_AXI_inst/send_inst/send_start_d0_reg/D]
