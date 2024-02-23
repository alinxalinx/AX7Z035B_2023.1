set_property PACKAGE_PIN AA15 [get_ports dac_ch0_clk]
set_property PACKAGE_PIN AA14 [get_ports dac_ch0_wrt]
set_property PACKAGE_PIN AC12 [get_ports {dac_ch0_data[0]}]
set_property PACKAGE_PIN AD11 [get_ports {dac_ch0_data[1]}]
set_property PACKAGE_PIN W13 [get_ports {dac_ch0_data[2]}]
set_property PACKAGE_PIN Y13 [get_ports {dac_ch0_data[3]}]
set_property PACKAGE_PIN AD13 [get_ports {dac_ch0_data[4]}]
set_property PACKAGE_PIN AC13 [get_ports {dac_ch0_data[5]}]
set_property PACKAGE_PIN AE11 [get_ports {dac_ch0_data[6]}]
set_property PACKAGE_PIN AF10 [get_ports {dac_ch0_data[7]}]
set_property PACKAGE_PIN AA13 [get_ports {dac_ch0_data[8]}]
set_property PACKAGE_PIN AA12 [get_ports {dac_ch0_data[9]}]
set_property PACKAGE_PIN AB12 [get_ports {dac_ch0_data[10]}]
set_property PACKAGE_PIN AC11 [get_ports {dac_ch0_data[11]}]
set_property PACKAGE_PIN Y12 [get_ports {dac_ch0_data[12]}]
set_property PACKAGE_PIN Y11 [get_ports {dac_ch0_data[13]}]

set_property PACKAGE_PIN Y10 [get_ports dac_ch1_clk]
set_property PACKAGE_PIN AA10 [get_ports dac_ch1_wrt]
set_property PACKAGE_PIN AB17 [get_ports {dac_ch1_data[0]}]
set_property PACKAGE_PIN AB16 [get_ports {dac_ch1_data[1]}]
set_property PACKAGE_PIN AB11 [get_ports {dac_ch1_data[2]}]
set_property PACKAGE_PIN AB10 [get_ports {dac_ch1_data[3]}]
set_property PACKAGE_PIN AF12 [get_ports {dac_ch1_data[4]}]
set_property PACKAGE_PIN AE12 [get_ports {dac_ch1_data[5]}]
set_property PACKAGE_PIN AE10 [get_ports {dac_ch1_data[6]}]
set_property PACKAGE_PIN AD10 [get_ports {dac_ch1_data[7]}]
set_property PACKAGE_PIN AC17 [get_ports {dac_ch1_data[8]}]
set_property PACKAGE_PIN AC16 [get_ports {dac_ch1_data[9]}]
set_property PACKAGE_PIN W16 [get_ports {dac_ch1_data[10]}]
set_property PACKAGE_PIN W15 [get_ports {dac_ch1_data[11]}]
set_property PACKAGE_PIN AE16 [get_ports {dac_ch1_data[12]}]
set_property PACKAGE_PIN AE15 [get_ports {dac_ch1_data[13]}]

set_property IOSTANDARD LVCMOS33 [get_ports dac_ch0_clk]
set_property IOSTANDARD LVCMOS33 [get_ports dac_ch0_wrt]
set_property IOSTANDARD LVCMOS33 [get_ports {dac_ch0_data[*]}]

set_property IOSTANDARD LVCMOS33 [get_ports dac_ch1_clk]
set_property IOSTANDARD LVCMOS33 [get_ports dac_ch1_wrt]
set_property IOSTANDARD LVCMOS33 [get_ports {dac_ch1_data[*]}]

set_false_path -reset_path -from [get_pins top_i/ad9767_send_0/inst/ad9767_send_v1_0_S00_AXI_inst/send_inst/st_clr_reg/C] -to [get_pins top_i/ad9767_send_0/inst/ad9767_send_v1_0_S00_AXI_inst/st_clr_d0_reg/D]
set_false_path -reset_path -from [get_pins {top_i/ad9767_send_0/inst/ad9767_send_v1_0_S00_AXI_inst/slv_reg0_reg[0]/C}] -to [get_pins top_i/ad9767_send_0/inst/ad9767_send_v1_0_S00_AXI_inst/send_inst/send_start_d0_reg/D]

set_false_path -reset_path -from [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/send_inst/st_clr_reg/C] -to [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/st_clr_d0_reg/D]
set_false_path -reset_path -from [get_pins {top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/slv_reg0_reg[0]/C}] -to [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/send_inst/send_start_d0_reg/D]


#set_false_path -from [get_pins {top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/slv_reg0_reg[0]/C}] -to [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/send_inst/send_start_d0_reg/D]
#set_false_path -from [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/send_inst/st_clr_reg/C] -to [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/st_clr_d0_reg/D]




set_false_path -from [get_pins {top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/slv_reg0_reg[0]/C}] -to [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/send_inst/send_start_d0_reg/D]
set_false_path -from [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/send_inst/st_clr_reg/C] -to [get_pins top_i/ad9767_send_1/inst/ad9767_send_v1_0_S00_AXI_inst/st_clr_d0_reg/D]
