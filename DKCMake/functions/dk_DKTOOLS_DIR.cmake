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
# dk_DKTOOLS_DIR()
#
#
function(dk_DKTOOLS_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGN)
		dk_set(DKTOOLS_DIR "${ARGN}")

	###### GET ######
	else()
		dk_validate(ENV{DIGITALKNOB_DIR} "dk_DIGITALKNOB_DIR()")
		dk_set(DKTOOLS_DIR "$ENV{DIGITALKNOB_DIR}/DKTools")
	endif()

	if(NOT EXISTS "$ENV{DKTOOLS_DIR}") 
		dk_mkdir("$ENV{DKTOOLS_DIR}")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting DKTOOLS_DIR . . .")
	dk_DKTOOLS_DIR()
	dk_printVar(ENV{DKTOOLS_DIR})

	dk_echo()
	dk_echo("Test Setting DKTOOLS_DIR . . .")
	dk_DKTOOLS_DIR("C:/DKTools")
	dk_printVar(ENV{DKTOOLS_DIR})
endfunction()
