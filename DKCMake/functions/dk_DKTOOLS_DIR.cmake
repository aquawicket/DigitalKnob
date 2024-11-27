#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

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
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		dk_set(DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools")
	endif()
	
	if(NOT EXISTS "${DKTOOLS_DIR}") 
		dk_makeDirectory("${DKTOOLS_DIR}")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
   
	dk_echo()
	dk_echo("Test Getting DKTOOLS_DIR . . .")
	dk_DKTOOLS_DIR()
	dk_printVar(DKTOOLS_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKTOOLS_DIR . . .")
	dk_DKTOOLS_DIR("C:/DKTools")
	dk_printVar(DKTOOLS_DIR)
endfunction()
