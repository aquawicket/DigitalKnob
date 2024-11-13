#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DKDOWNLOAD_DIR()
#
#
function(dk_DKDOWNLOAD_DIR)
    dk_debugFunc()
            
	### DIGITALKNOB_DIR ###
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
	
	### DKDOWNLOAD_DIR ###
	dk_set(DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download")
	set(ENV{DKDOWNLOAD_DIR} "${DIGITALKNOB_DIR}/download")
	if(NOT EXISTS "${DKDOWNLOAD_DIR}") 
		dk_makeDirectory("${DKDOWNLOAD_DIR}")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_DKDOWNLOAD_DIR()
    dk_printVar(DKDOWNLOAD_DIR)
endfunction()
