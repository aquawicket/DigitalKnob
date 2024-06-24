include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_call(func) args
#
#	load a ${func}.cmake file located in the DKCMake path and call the function with arguments
#
#	@func				- The name of the .cmake function file as well as the name of the function
#	@args (optional) 	- The arguments to pass to the function
#
function(dk_call func) #parameters
	dk_debugFunc(${ARGV})
	
	dk_load(${func})
	dk_eval("${func}($ARGN)")
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
