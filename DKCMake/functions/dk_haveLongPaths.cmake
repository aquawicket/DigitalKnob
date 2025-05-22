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
# dk_haveLongPaths(rtn_var)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
function(dk_haveLongPaths)
	dk_debugFunc(0 1)
	
	#if(CMAKE_SYSTEM_NAME MATCHES "Windows")
    if(WIN32_LONG_PATHS)
        #message("Long paths are enabled")
		set(dk_haveLongPaths 1)
    else()
        #message("Long paths are not enabled")
		set(dk_haveLongPaths 0)
    endif()
	
	set(dk_haveLongPaths ${dk_haveLongPaths} PARENT_SCOPE)
	if(ARGV0)
		set(${ARGV0} ${dk_haveLongPaths} PARENT_SCOPE)
	endif()
	#endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_haveLongPaths()
	dk_echo("dk_haveLongPaths = ${dk_haveLongPaths}")
endfunction()















