##################Compress Bitstream############################
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

set_property PACKAGE_PIN C8 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]

create_clock -period 5.000 -name sys_clk_p -waveform {0.000 2.500} [get_ports sys_clk_p]

set_property PACKAGE_PIN AF15 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

############## UART ##################
set_property IOSTANDARD LVCMOS33 [get_ports rs422_rx1]
set_property PACKAGE_PIN AC16 [get_ports rs422_rx1]

set_property IOSTANDARD LVCMOS33 [get_ports rs422_tx1]
set_property PACKAGE_PIN AC17 [get_ports rs422_tx1]

set_property IOSTANDARD LVCMOS33 [get_ports rs422_rx2]
set_property PACKAGE_PIN AE15 [get_ports rs422_rx2]

set_property IOSTANDARD LVCMOS33 [get_ports rs422_tx2]
set_property PACKAGE_PIN AE16 [get_ports rs422_tx2]