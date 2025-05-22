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

####################################################################
# dk_DKDESKTOP_DIR()
#
#
function(dk_DKDESKTOP_DIR)
    dk_debugFunc(0 1)

	###### SET ######
	if(ARGN)
		dk_set(DKDESKTOP_DIR "${ARGN}")
		
	###### GET ######
	else()
		dk_validate(ENV{DKHOME_DIR} "dk_DKHOME_DIR()")
		dk_set(DKDESKTOP_DIR "$ENV{DKHOME_DIR}/Desktop")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKDESKTOP_DIR . . .")
	dk_DKDESKTOP_DIR()
	dk_printVar(DKDESKTOP_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKDESKTOP_DIR . . .")
	dk_DKDESKTOP_DIR("C:/Desktop")
	dk_printVar(DKDESKTOP_DIR)
endfunction()
