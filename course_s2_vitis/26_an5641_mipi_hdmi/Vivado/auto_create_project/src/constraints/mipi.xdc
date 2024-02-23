set_property PACKAGE_PIN AE21 [get_ports {cam_gpio_tri_io[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {cam_gpio_tri_io[0]}]
set_property PULLUP true [get_ports {cam_gpio_tri_io[0]}]

set_property -dict {PACKAGE_PIN AC19 IOSTANDARD LVCMOS33} [get_ports cam_i2c_scl_io]
set_property -dict {PACKAGE_PIN AC18 IOSTANDARD LVCMOS33} [get_ports cam_i2c_sda_io]

set_property PULLUP true [get_ports cam_i2c_scl_io]
set_property PULLUP true [get_ports cam_i2c_sda_io]

set_property INTERNAL_VREF 0.6 [get_iobanks 13]

set_property -dict {PACKAGE_PIN AF18 IOSTANDARD HSUL_12} [get_ports mipi_phy_if_clk_lp_n]
set_property -dict {PACKAGE_PIN AE18 IOSTANDARD HSUL_12} [get_ports mipi_phy_if_clk_lp_p]

set_property -dict {PACKAGE_PIN AE22 IOSTANDARD HSUL_12} [get_ports {mipi_phy_if_data_lp_n[0]}]
set_property -dict {PACKAGE_PIN AF22 IOSTANDARD HSUL_12} [get_ports {mipi_phy_if_data_lp_p[0]}]
set_property -dict {PACKAGE_PIN AA20 IOSTANDARD HSUL_12} [get_ports {mipi_phy_if_data_lp_n[1]}]
set_property -dict {PACKAGE_PIN AB20 IOSTANDARD HSUL_12} [get_ports {mipi_phy_if_data_lp_p[1]}]

set_property -dict {PACKAGE_PIN AC22 IOSTANDARD LVDS_25} [get_ports mipi_phy_if_clk_hs_n]
set_property -dict {PACKAGE_PIN AC21 IOSTANDARD LVDS_25} [get_ports mipi_phy_if_clk_hs_p]


set_property -dict {PACKAGE_PIN AB22 IOSTANDARD LVDS_25} [get_ports {mipi_phy_if_data_hs_n[0]}]
set_property -dict {PACKAGE_PIN AB21 IOSTANDARD LVDS_25} [get_ports {mipi_phy_if_data_hs_p[0]}]
set_property -dict {PACKAGE_PIN AD21 IOSTANDARD LVDS_25} [get_ports {mipi_phy_if_data_hs_n[1]}]
set_property -dict {PACKAGE_PIN AD20 IOSTANDARD LVDS_25} [get_ports {mipi_phy_if_data_hs_p[1]}]

