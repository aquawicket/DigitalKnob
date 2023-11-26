include_guard()

##################################################################################
# dk_Call(func) parameters
#
#	call a function and pass arguments
#
#	@func	- TODO
#
macro(dk_call func) #parameters
	dk_cmakeLanguage("${func}($ARGN)")
endmacro()
