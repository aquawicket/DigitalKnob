#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DKTOOLS_DIR()
#
#
function(dk_DKTOOLS_DIR)
    dk_debugFunc()

    if(EXISTS "${DKTOOLS_DIR}")
		return()
	endif()
            
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		
	### DKTOOLS_DIR ###
	dk_set(DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools")
	set(ENV{DKTOOLS_DIR} "${DIGITALKNOB_DIR}/DKTools")
	if(NOT EXISTS "${DKTOOLS_DIR}") 
		dk_makeDirectory("${DKTOOLS_DIR}")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_DKTOOLS_DIR()
    dk_printVar(DKTOOLS_DIR)
endfunction()
