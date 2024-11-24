#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DKAPPS_DIR()
#
#
function(dk_DKAPPS_DIR)
	dk_debugFunc()
	
	###### SET ######
	if(ARGV0)
		dk_set(DKAPPS_DIR "${ARGV0}")
		
	###### GET ######
	else()
		dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		dk_set(DKAPPS_DIR "${DKBRANCH_DIR}/DKApps")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_DKAPPS_DIR()
	dk_printVar(DKAPPS_DIR)
endfunction()
