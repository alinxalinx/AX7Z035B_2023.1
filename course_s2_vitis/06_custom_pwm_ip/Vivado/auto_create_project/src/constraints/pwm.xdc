set_property BITSTREAM.GENERAL.COMPRESS TRUE [current_design]
set_property CONFIG_VOLTAGE 3.3 [current_design]
set_property CFGBVS VCCO [current_design]
set_property BITSTREAM.CONFIG.UNUSEDPIN PULLUP [current_design]

set_property IOSTANDARD LVCMOS33 [get_ports pwm_0]
set_property PACKAGE_PIN AB15 [get_ports pwm_0]