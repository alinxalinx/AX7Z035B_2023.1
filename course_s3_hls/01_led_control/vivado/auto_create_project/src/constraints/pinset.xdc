set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

set_property PACKAGE_PIN C8 [get_ports refclk_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports refclk_clk_p]
set_property PACKAGE_PIN AB15   [get_ports {led_V_0 [0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {led_V_0 [0]}]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets design_1_i/clk_wiz_0/inst/clk_in1_design_1_clk_wiz_0_0] 


