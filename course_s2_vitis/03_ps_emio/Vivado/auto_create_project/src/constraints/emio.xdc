set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]

set_property IOSTANDARD LVCMOS33 [get_ports {emio_tri_io[*]}]
#pl led
set_property PACKAGE_PIN AB15 [get_ports {emio_tri_io[0]}]
set_property PACKAGE_PIN AB14 [get_ports {emio_tri_io[1]}]
set_property PACKAGE_PIN AF13 [get_ports {emio_tri_io[2]}]
set_property PACKAGE_PIN AE13 [get_ports {emio_tri_io[3]}]
#pl key
set_property PACKAGE_PIN AF15 [get_ports {emio_tri_io[4]}]