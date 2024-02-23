set_property PACKAGE_PIN AA10  [get_ports {cmos1_i2c_sda_io}]
set_property PACKAGE_PIN AE15  [get_ports {cmos1_d[9]}]
set_property PACKAGE_PIN AE16  [get_ports {cmos1_d[8]}]
set_property PACKAGE_PIN W15  [get_ports {cmos1_i2c_scl_io}]
set_property PACKAGE_PIN W16   [get_ports {cmos1_d[5]}]
set_property PACKAGE_PIN AC16  [get_ports {cmos1_d[3]}]
set_property PACKAGE_PIN AC17  [get_ports {cmos1_d[4]}]
set_property PACKAGE_PIN AD10  [get_ports {cmos1_d[6]}]
set_property PACKAGE_PIN AE10  [get_ports {cmos1_d[0]}]
set_property PACKAGE_PIN AE12  [get_ports {cmos1_d[7]}]
set_property PACKAGE_PIN AF12  [get_ports {cmos1_d[1]}]
set_property PACKAGE_PIN AB10  [get_ports {cmos1_d[2]}]
set_property PACKAGE_PIN AB11  [get_ports {cmos1_pclk}]
set_property PACKAGE_PIN AB16  [get_ports {cmos1_href}]
set_property PACKAGE_PIN AB17  [get_ports {cmos1_vsync}]
set_property PACKAGE_PIN AA17  [get_ports {cmos_rstn_tri_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_i2c_sda_io}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[9]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[8]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_i2c_scl_io}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[5]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[3]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[4]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[6]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[7]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[1]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_d[2]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_pclk}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_href}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos1_vsync}]
set_property IOSTANDARD LVCMOS33 [get_ports {cmos_rstn_tri_o[0]}]

set_property PULLUP true [get_ports cmos1_i2c_scl_io]
set_property PULLUP true [get_ports cmos1_i2c_sda_io]

set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets cmos1_pclk_IBUF]