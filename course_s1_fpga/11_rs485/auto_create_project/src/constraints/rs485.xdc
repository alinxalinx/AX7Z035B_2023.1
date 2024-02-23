##################Compress Bitstream############################
set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

set_property PACKAGE_PIN C8 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]

create_clock -period 5.000 -name sys_clk_p -waveform {0.000 2.500} [get_ports sys_clk_p]

set_property PACKAGE_PIN AF15 [get_ports rst_n]
set_property IOSTANDARD LVCMOS33 [get_ports rst_n]

############## UART ##################
set_property IOSTANDARD LVCMOS33 [get_ports rs485_rx1]
set_property PACKAGE_PIN AC11 [get_ports rs485_rx1]
set_property IOSTANDARD LVCMOS33 [get_ports rs485_tx1]
set_property PACKAGE_PIN AA12 [get_ports rs485_tx1]
set_property IOSTANDARD LVCMOS33 [get_ports rs485_de1]
set_property PACKAGE_PIN AB12 [get_ports rs485_de1]

set_property IOSTANDARD LVCMOS33 [get_ports rs485_rx2]
set_property PACKAGE_PIN AC13 [get_ports rs485_rx2]
set_property IOSTANDARD LVCMOS33 [get_ports rs485_tx2]
set_property PACKAGE_PIN Y13 [get_ports rs485_tx2]
set_property IOSTANDARD LVCMOS33 [get_ports rs485_de2]
set_property PACKAGE_PIN AD13 [get_ports rs485_de2]

