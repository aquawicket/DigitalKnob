#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_haveLongPaths(rtn_var)
#
#	Print a info message to the console
#
#	@msg	- The message to print
#
function(dk_haveLongPaths)
	dk_debugFunc(0 1)
	
    if(WIN32_LONG_PATHS)
        #dk_debug("Long paths are enabled")
		set(dk_haveLongPaths 1)
    else()
        #dk_debug("Long paths are not enabled")
		set(dk_haveLongPaths 0)
    endif()
	
	set(dk_haveLongPaths ${dk_haveLongPaths} PARENT_SCOPE)
	if(ARGV)
		set(${ARGV0} ${dk_haveLongPaths} PARENT_SCOPE)
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_haveLongPaths()
	dk_echo("dk_haveLongPaths = ${dk_haveLongPaths}")
endfunction()















