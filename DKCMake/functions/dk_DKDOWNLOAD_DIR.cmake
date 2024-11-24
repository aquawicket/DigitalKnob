#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DKDOWNLOAD_DIR()
#
#
function(dk_DKDOWNLOAD_DIR)
    dk_debugFunc()
            
	###### SET ######
	if(ARGV0)
		dk_set(DKDOWNLOAD_DIR "${ARGV0}")
		
	###### GET ######
	else()
		dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		dk_set(DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download")
	endif()
	
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
