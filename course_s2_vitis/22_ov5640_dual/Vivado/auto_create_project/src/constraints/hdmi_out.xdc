set_property PACKAGE_PIN K15  [get_ports hdmi_out_clk]
set_property PACKAGE_PIN H13 [get_ports {hdmi_out_data[0]}]
set_property PACKAGE_PIN E11 [get_ports {hdmi_out_data[1]}]
set_property PACKAGE_PIN D11 [get_ports {hdmi_out_data[2]}]
set_property PACKAGE_PIN G11 [get_ports {hdmi_out_data[3]}]
set_property PACKAGE_PIN G12 [get_ports {hdmi_out_data[4]}]
set_property PACKAGE_PIN K13 [get_ports {hdmi_out_data[5]}]
set_property PACKAGE_PIN J13 [get_ports {hdmi_out_data[6]}]
set_property PACKAGE_PIN J14 [get_ports {hdmi_out_data[7]}]
set_property PACKAGE_PIN H14 [get_ports {hdmi_out_data[8]}]
set_property PACKAGE_PIN J15 [get_ports {hdmi_out_data[9]}]
set_property PACKAGE_PIN E12 [get_ports {hdmi_out_data[10]}]
set_property PACKAGE_PIN F12 [get_ports {hdmi_out_data[11]}]
set_property PACKAGE_PIN B15 [get_ports {hdmi_out_data[12]}]
set_property PACKAGE_PIN B16 [get_ports {hdmi_out_data[13]}]
set_property PACKAGE_PIN B14 [get_ports {hdmi_out_data[14]}]
set_property PACKAGE_PIN C14 [get_ports {hdmi_out_data[15]}]
set_property PACKAGE_PIN G15 [get_ports {hdmi_out_data[16]}]
set_property PACKAGE_PIN G16 [get_ports {hdmi_out_data[17]}]
set_property PACKAGE_PIN D14 [get_ports {hdmi_out_data[18]}]
set_property PACKAGE_PIN D15 [get_ports {hdmi_out_data[19]}]
set_property PACKAGE_PIN D16 [get_ports {hdmi_out_data[20]}]
set_property PACKAGE_PIN E16 [get_ports {hdmi_out_data[21]}]
set_property PACKAGE_PIN C17 [get_ports {hdmi_out_data[22]}]
set_property PACKAGE_PIN C16 [get_ports {hdmi_out_data[23]}]
set_property PACKAGE_PIN H12 [get_ports hdmi_out_de]
set_property PACKAGE_PIN F10 [get_ports hdmi_out_hs]
set_property PACKAGE_PIN G10 [get_ports hdmi_out_vs]
set_property PACKAGE_PIN B17 [get_ports hdmi_i2c_scl_io]
set_property PACKAGE_PIN A17 [get_ports hdmi_i2c_sda_io]

set_property IOSTANDARD LVCMOS18 [get_ports hdmi_i2c_scl_io]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_i2c_sda_io]
set_property IOSTANDARD LVCMOS18 [get_ports {hdmi_out_data[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_out_clk]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_out_de]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_out_vs]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_out_hs]

set_property PULLUP true [get_ports hdmi_i2c_scl_io]
set_property PULLUP true [get_ports hdmi_i2c_sda_io]

set_property SLEW FAST [get_ports {hdmi_out_data[*]}]
set_property DRIVE 8 [get_ports {hdmi_out_data[*]}]
set_property SLEW FAST [get_ports hdmi_out_clk]
set_property SLEW FAST [get_ports hdmi_out_de]
set_property SLEW FAST [get_ports hdmi_out_hs]
set_property SLEW FAST [get_ports hdmi_i2c_scl_io]
set_property SLEW FAST [get_ports hdmi_i2c_sda_io]
set_property SLEW FAST [get_ports hdmi_out_vs]