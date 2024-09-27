#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DIGITALKNOB_DIR()
#
#
function(dk_DIGITALKNOB_DIR)
    dk_debugFunc("\${ARGV}")

    if(DEFINED DIGITALKNOB_DIR)
		return()
	endif()
            
    dk_DKHOME_DIR()
    #if(NOT DEFINED DIGITALKNOB set "DIGITALKNOB=D i g i t a l K n o b")
    if(NOT DEFINED DIGITALKNOB)
		dk_set(DIGITALKNOB "digitalknob")
	endif()
    dk_set(DIGITALKNOB_DIR "${DKHOME_DIR}/${DIGITALKNOB}")
    if(NOT EXISTS "${DIGITALKNOB_DIR}")
		dk_makeDirectory("${DIGITALKNOB_DIR}")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
   
	dk_DIGITALKNOB_DIR()
    dk_printVar(DIGITALKNOB_DIR)
endfunction()
