#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

####################################################################
# dk_timeout_exe()
#
#
function(dk_timeout_exe)
    dk_debugFunc()

	if(EXISTS "${timeout_exe}")
		dk_debug("timeout_exe:${timeout_exe} already set")
		return()
	endif()
	
	###### timeout_exe ######
	if(NOT EXISTS "${timeout_exe}")
		dk_findProgram(timeout_exe "timeout.exe")
	endif()
	if(NOT EXISTS "${timeout_exe}")
		dk_set(timeout_exe "$ENV{timeout_exe}")
	endif()
	if(NOT EXISTS "${timeout_exe}")
		dk_set(timeout_exe "/c/Windows/System32/cmd.exe")
	endif()
	if(NOT EXISTS "${timeout_exe}")
		dk_set(timeout_exe "/mnt/c/Windows/System32/cmd.exe")
	endif()
	if(NOT EXISTS "${timeout_exe}")
		dk_warning("timeout_exe:${timeout_exe} not found")
	else()
		dk_set(timeout_exe "${timeout_exe}")				# Globalize the variable
		set(ENV{timeout_exe} "${timeout_exe}")				# Set Environment Varible
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
    dk_timeout_exe()
    dk_printVar(timeout_exe)
endfunction()
