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

###############################################################################
# dk_setEnv(name value)
#
#	Set a system environment variable
#
#	@name	- The name of the system environment variable to set
#	@value	- The value to set the system environment vairable to
#
# BE CAREFUL WITH THIS. It can make the shell unresponsive to commands
function(dk_setEnv name value)
	dk_debugFunc()
	
	if(EXISTS "${value}")
		dk_nativePath("${value}" value)
	endif()
	if(DEFINED ENV{${name}})
		if("$ENV{${name}}" STREQUAL "${value}")
			dk_notice("${name} is already set to ${value}, skipping...")
		else()
			dk_notice("updating ENV{${name}}")
		endif()
	endif()

	set(ENV{${name}} "${value}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_setEnv(todo)
endfunction()