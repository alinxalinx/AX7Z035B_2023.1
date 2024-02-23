# Definitional proc to organize widgets for parameters.
proc init_gui { IPINST } {
  ipgui::add_param $IPINST -name "Component_Name"
  #Adding Page
  set Page_0 [ipgui::add_page $IPINST -name "Page 0"]
  ipgui::add_param $IPINST -name "PIXELS_FORMAT" -parent ${Page_0}


}

proc update_PARAM_VALUE.PIXELS_FORMAT { PARAM_VALUE.PIXELS_FORMAT } {
	# Procedure called to update PIXELS_FORMAT when any of the dependent parameters in the arguments change
}

proc validate_PARAM_VALUE.PIXELS_FORMAT { PARAM_VALUE.PIXELS_FORMAT } {
	# Procedure called to validate PIXELS_FORMAT
	return true
}


proc update_MODELPARAM_VALUE.PIXELS_FORMAT { MODELPARAM_VALUE.PIXELS_FORMAT PARAM_VALUE.PIXELS_FORMAT } {
	# Procedure called to set VHDL generic/Verilog parameter value(s) based on TCL parameter value
	set_property value [get_property value ${PARAM_VALUE.PIXELS_FORMAT}] ${MODELPARAM_VALUE.PIXELS_FORMAT}
}

