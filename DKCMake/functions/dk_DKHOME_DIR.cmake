#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

####################################################################
# dk_DKHOME_DIR()
#
#
function(dk_DKHOME_DIR)
    dk_debugFunc("\${ARGV}")

    if(DEFINED DKHOME_DIR)
		return()
	endif()
    
    if(NOT DEFINED ENV{HOMEDRIVE})
		dk_error("HOMEDRIVE is invalid")
	endif()
	
    if(NOT DEFINED ENV{HOMEPATH})
		dk_error("HOMEPATH is invalid")
	endif()
	
    dk_set(DKHOME_DIR "$ENV{HOMEDRIVE}$ENV{HOMEPATH}")
	dk_replaceAll("${DKHOME_DIR}" "\\" "/" DKHOME_DIR)
	dk_set(DKHOME_DIR "${DKHOME_DIR}")
    if(NOT EXISTS "${DKHOME_DIR}")
		dk_error("DKHOME_DIR:${DKHOME_DIR} does not exist")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
 
    dk_DKHOME_DIR()
    dk_printVar(DKHOME_DIR)
endfunction()
