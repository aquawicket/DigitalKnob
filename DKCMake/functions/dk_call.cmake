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
function(dk_call)
	dk_debugFunc(${ARGV})
	
	if(NOT COMMAND ${ARGV0})
		#if("${ARGV0}" =~ ^dk_[a-zA-Z0-9]+ ]])
			dk_source(${ARGV0})
		#else()				
		#	dk _commandExists(dk_install)  || dk_source(dk_install)
		#	dk _install ${1}
		#endif()
		if(NOT COMMAND ${ARGV0})
			dk_error("${ARGV0}: command not found")
		endif()
	endif()
	
	dk_echo("${ARGV0}(${ARGV1})")
	dk_eval("${ARGV0}(${ARGV1})")
endfunction()






function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_call(dk_debug "\"test message using dk_call\"")
	dk_call(dk_pause)
endfunction()
