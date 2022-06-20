include_guard()
dk_load(dk_color)

##################################################################################
# dk_message(msg)
#
#	Print a message to the console or terminal
#
#	@msg:(required)	The message to print
#
macro(dk_message msg)
	message(STATUS "${H_black}${STACK_HEADER}${CLR}${msg}")
endmacro()