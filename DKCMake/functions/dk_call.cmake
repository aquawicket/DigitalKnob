#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	dk_debugFunc(0)
	
	dk_call( dk_debug("test message using dk_call") )
endfunction()
