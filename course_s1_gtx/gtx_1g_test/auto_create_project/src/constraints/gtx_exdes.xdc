set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

############# clock define################################
create_clock -period 5.000 [get_ports sys_clk_p]
set_property PACKAGE_PIN C8 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]
############## key define##################
set_property PACKAGE_PIN AF15 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]
############## fan define##################
set_property IOSTANDARD LVCMOS33 [get_ports fan_pwm]
set_property PACKAGE_PIN Y15 [get_ports fan_pwm]

####################### GT reference clock constraints #########################
create_clock -period 8.000 [get_ports Q2_CLK0_GTREFCLK_PAD_P_IN]

################################# RefClk Location constraints #####################
set_property PACKAGE_PIN AA5 [get_ports Q2_CLK0_GTREFCLK_PAD_N_IN]
set_property PACKAGE_PIN AA6 [get_ports Q2_CLK0_GTREFCLK_PAD_P_IN]


set_property PACKAGE_PIN AF17 [get_ports {tx_disable[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_disable[0]}]

set_property PACKAGE_PIN AE17 [get_ports {tx_disable[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {tx_disable[1]}]



################################# mgt wrapper constraints #####################
set_property LOC GTXE2_CHANNEL_X0Y8 [get_cells gtx_exdes_m0/gtx_support_i/gtx_init_i/inst/gtx_i/gt0_gtx_i/gtxe2_i]
##---------- Set placement for gt1_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y9 [get_cells gtx_exdes_m0/gtx_support_i/gtx_init_i/inst/gtx_i/gt1_gtx_i/gtxe2_i]
##---------- Set placement for gt2_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y10 [get_cells gtx_exdes_m0/gtx_support_i/gtx_init_i/inst/gtx_i/gt2_gtx_i/gtxe2_i]
##---------- Set placement for gt3_gtx_wrapper_i/GTXE2_CHANNEL ------
set_property LOC GTXE2_CHANNEL_X0Y11 [get_cells gtx_exdes_m0/gtx_support_i/gtx_init_i/inst/gtx_i/gt3_gtx_i/gtxe2_i]
