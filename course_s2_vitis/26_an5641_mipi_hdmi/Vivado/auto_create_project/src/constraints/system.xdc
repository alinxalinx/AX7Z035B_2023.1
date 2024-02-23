set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]

#LED
set_property IOSTANDARD LVCMOS33 [get_ports {leds_tri_o[0]}]
set_property PACKAGE_PIN AB15 [get_ports {leds_tri_o[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {leds_tri_o[1]}]
set_property PACKAGE_PIN AB14 [get_ports {leds_tri_o[1]}]
