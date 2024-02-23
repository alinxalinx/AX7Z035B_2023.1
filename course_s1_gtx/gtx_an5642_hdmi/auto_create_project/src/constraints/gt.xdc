####################### GT reference clock constraints #########################


create_clock -period 8.000 [get_ports Q2_CLK0_GTREFCLK_PAD_P_IN]





#create_clock -period 5.000 -name drpclk_in_i [get_ports DRP_CLK_IN_P]





# User Clock Constraints





#set_false_path -to [get_pins -hierarchical -filter {NAME =~ *_txfsmresetdone_r*/CLR}]
#set_false_path -to [get_pins -hierarchical -filter {NAME =~ *_txfsmresetdone_r*/D}]
#set_false_path -to [get_pins -hierarchical -filter {NAME =~ *reset_on_error_in_r*/D}]
################################# RefClk Location constraints #####################
set_property PACKAGE_PIN AA5 [get_ports Q2_CLK0_GTREFCLK_PAD_N_IN]
set_property PACKAGE_PIN AA6 [get_ports Q2_CLK0_GTREFCLK_PAD_P_IN]

## LOC constrain for DRP_CLK_P/N
#set_property IOSTANDARD DIFF_SSTL15 [get_ports DRP_CLK_IN_P]
#set_property IOSTANDARD DIFF_SSTL15 [get_ports DRP_CLK_IN_N]
#set_property PACKAGE_PIN R4 [get_ports DRP_CLK_IN_P]
#set_property PACKAGE_PIN T4 [get_ports DRP_CLK_IN_N]

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





connect_debug_port u_ila_1/clk [get_nets [list gtx_exdes_m0/gtx_support_i/gt_usrclk_source/txoutclk_mmcm0_i/CLK0_OUT]]

