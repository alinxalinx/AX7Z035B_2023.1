set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
############## clock define##################
create_clock -period 5.000 [get_ports sys_clk_p]
set_property PACKAGE_PIN C8 [get_ports sys_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_clk_p]

set_property IOSTANDARD LVCMOS33 [get_ports {rst_n}]
set_property PACKAGE_PIN AF15 [get_ports {rst_n}]

set_property PACKAGE_PIN K15  [get_ports hdmi_clk]
set_property PACKAGE_PIN H13 [get_ports {hdmi_d[0]}]
set_property PACKAGE_PIN E11 [get_ports {hdmi_d[1]}]
set_property PACKAGE_PIN D11 [get_ports {hdmi_d[2]}]
set_property PACKAGE_PIN G11 [get_ports {hdmi_d[3]}]
set_property PACKAGE_PIN G12 [get_ports {hdmi_d[4]}]
set_property PACKAGE_PIN K13 [get_ports {hdmi_d[5]}]
set_property PACKAGE_PIN J13 [get_ports {hdmi_d[6]}]
set_property PACKAGE_PIN J14 [get_ports {hdmi_d[7]}]
set_property PACKAGE_PIN H14 [get_ports {hdmi_d[8]}]
set_property PACKAGE_PIN J15 [get_ports {hdmi_d[9]}]
set_property PACKAGE_PIN E12 [get_ports {hdmi_d[10]}]
set_property PACKAGE_PIN F12 [get_ports {hdmi_d[11]}]
set_property PACKAGE_PIN B15 [get_ports {hdmi_d[12]}]
set_property PACKAGE_PIN B16 [get_ports {hdmi_d[13]}]
set_property PACKAGE_PIN B14 [get_ports {hdmi_d[14]}]
set_property PACKAGE_PIN C14 [get_ports {hdmi_d[15]}]
set_property PACKAGE_PIN G15 [get_ports {hdmi_d[16]}]
set_property PACKAGE_PIN G16 [get_ports {hdmi_d[17]}]
set_property PACKAGE_PIN D14 [get_ports {hdmi_d[18]}]
set_property PACKAGE_PIN D15 [get_ports {hdmi_d[19]}]
set_property PACKAGE_PIN D16 [get_ports {hdmi_d[20]}]
set_property PACKAGE_PIN E16 [get_ports {hdmi_d[21]}]
set_property PACKAGE_PIN C17 [get_ports {hdmi_d[22]}]
set_property PACKAGE_PIN C16 [get_ports {hdmi_d[23]}]
set_property PACKAGE_PIN H12 [get_ports hdmi_de]
set_property PACKAGE_PIN F10 [get_ports hdmi_hs]
set_property PACKAGE_PIN G10 [get_ports hdmi_vs]
set_property PACKAGE_PIN B17 [get_ports hdmi_scl]
set_property PACKAGE_PIN A17 [get_ports hdmi_sda]

set_property IOSTANDARD LVCMOS18 [get_ports hdmi_scl]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_sda]
set_property IOSTANDARD LVCMOS18 [get_ports {hdmi_d[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_clk]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_de]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_vs]
set_property IOSTANDARD LVCMOS18 [get_ports hdmi_hs]

set_property PULLUP true [get_ports hdmi_scl]
set_property PULLUP true [get_ports hdmi_sda]

set_property SLEW FAST [get_ports {hdmi_d[*]}]
set_property DRIVE 8 [get_ports {hdmi_d[*]}]
set_property SLEW FAST [get_ports hdmi_clk]
set_property SLEW FAST [get_ports hdmi_de]
set_property SLEW FAST [get_ports hdmi_hs]
set_property SLEW FAST [get_ports hdmi_scl]
set_property SLEW FAST [get_ports hdmi_sda]
set_property SLEW FAST [get_ports hdmi_vs]


########AN706##################
set_property PACKAGE_PIN Y12 [get_ports {ad7606_os[0]}]
set_property PACKAGE_PIN Y11 [get_ports {ad7606_os[1]}]
set_property PACKAGE_PIN AB12 [get_ports {ad7606_os[2]}]
set_property PACKAGE_PIN AC11 [get_ports ad7606_convstab]
set_property PACKAGE_PIN AA13 [get_ports ad7606_reset]
set_property PACKAGE_PIN AA12 [get_ports ad7606_rd]
set_property PACKAGE_PIN AE11 [get_ports ad7606_cs]
set_property PACKAGE_PIN AF10 [get_ports ad7606_busy]
set_property PACKAGE_PIN AD13 [get_ports ad7606_first_data]
set_property PACKAGE_PIN AD11  [get_ports {ad7606_data[0]}]
set_property PACKAGE_PIN AC12  [get_ports {ad7606_data[1]}]
set_property PACKAGE_PIN AA14  [get_ports {ad7606_data[2]}]
set_property PACKAGE_PIN AA15  [get_ports {ad7606_data[3]}]
set_property PACKAGE_PIN Y10	  [get_ports {ad7606_data[4]}]
set_property PACKAGE_PIN AA10  [get_ports {ad7606_data[5]}]
set_property PACKAGE_PIN AE15  [get_ports {ad7606_data[6]}]
set_property PACKAGE_PIN AE16  [get_ports {ad7606_data[7]}]
set_property PACKAGE_PIN W15	  [get_ports {ad7606_data[8]}]
set_property PACKAGE_PIN W16	  [get_ports {ad7606_data[9]}]
set_property PACKAGE_PIN AC16  [get_ports {ad7606_data[10]}]
set_property PACKAGE_PIN AC17  [get_ports {ad7606_data[11]}]
set_property PACKAGE_PIN AD10  [get_ports {ad7606_data[12]}]
set_property PACKAGE_PIN AE10  [get_ports {ad7606_data[13]}]
set_property PACKAGE_PIN AE12  [get_ports {ad7606_data[14]}]
set_property PACKAGE_PIN AF12  [get_ports {ad7606_data[15]}]



set_property IOSTANDARD LVCMOS33 [get_ports ad7606_convstab]
set_property IOSTANDARD LVCMOS33 [get_ports ad7606_reset]
set_property IOSTANDARD LVCMOS33 [get_ports ad7606_rd]
set_property IOSTANDARD LVCMOS33 [get_ports ad7606_cs]
set_property IOSTANDARD LVCMOS33 [get_ports ad7606_busy]
set_property IOSTANDARD LVCMOS33 [get_ports ad7606_first_data]
set_property IOSTANDARD LVCMOS33 [get_ports {ad7606_os[*]}]
set_property IOSTANDARD LVCMOS33 [get_ports {ad7606_data[*]}]