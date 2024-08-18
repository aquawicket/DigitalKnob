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
macro(dk_call func)
#function(dk_call func)
	dk_debugFunc(${ARGV})
	if(NOT COMMAND ${func})
		#if("${ARGV0}" =~ ^dk_[a-zA-Z0-9]+ ]])
			dk_source(${func})
		#else()				
		#	dk _commandExists(dk_install)  || dk_source(dk_install)
		#	dk _install ${1}
		#endif()
		if(NOT COMMAND ${func})
			dk_error("${func}: command not found")
		endif()
	endif()
	
	unset(args)
	list(APPEND args ${ARGN})
	list(REMOVE_ITEM args "(" ")")

	dk_debug("${func}(${args})")
	cmake_language(CALL ${func} ${args})
#endfunction()
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_call( dk_debug("test message using dk_call") )
endfunction()
