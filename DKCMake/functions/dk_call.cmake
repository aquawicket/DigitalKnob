include_guard()
dk_load(dk_eval)
##################################################################################
# dk_call(func) args
#
#	load a ${func}.cmake file located in the DKCMake path and call the function with arguments
#
#	@func				- The name of the .cmake function file as well as the name of the function
#	@args (optional) 	- The arguments to pass to the function
#
macro(dk_call func) #parameters
	#DKDEBUGFUNC(${ARGV})
	dk_load(${func})
	dk_eval("${func}($ARGN)")
endmacro()
