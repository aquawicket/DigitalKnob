include_guard()
#include(${DKCMAKE}/dk_load.cmake)

##################################################################################
# dk_Call(func) parameters
#
#	load a ${func}.cmake file located in the DKCMake path amd call the function and pass arguments
#
#	@func	- TODO
#
macro(dk_call func) #parameters
	#dk_load(${func})
	dk_cmakeLanguage("${func}($ARGN)")
endmacro()
