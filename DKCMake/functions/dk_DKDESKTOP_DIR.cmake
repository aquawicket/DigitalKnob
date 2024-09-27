#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

####################################################################
# dk_DKDESKTOP_DIR()
#
#
function(dk_DKDESKTOP_DIR)
    dk_debugFunc("\${ARGV}")
   
	if(DEFINED DKDESKTOP_DIR)
		return()
	endif()
    
	dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
	dk_set(DKDESKTOP_DIR "${DKHOME_DIR}/Desktop")
	if(NOT EXISTS "${DKDESKTOP_DIR}") 
		dk_makeDirectory("${DKDESKTOP_DIR}")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
 
    dk_DKDESKTOP_DIR
    dk_printVar(DKDESKTOP_DIR)
endfunction()
