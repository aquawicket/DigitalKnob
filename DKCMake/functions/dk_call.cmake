#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
	dk_debugFunc()
	if(NOT COMMAND ${func})
		#if("${ARGV0}" =~ ^dk_[a-zA-Z0-9]+ ]])
			dk_source(${func})
		#else()				
		#	dk _commandExists(dk_install)  || dk_source(dk_install)
		#	dk _install ${1}
		#endif()
		if(NOT COMMAND ${func})
			dk_fatal("${func}: command not found")
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
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_call( dk_debug("test message using dk_call") )
endfunction()
