#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DKAPPS_DIR()
#
#
function(dk_DKAPPS_DIR)
	dk_debugFunc()
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	
		dk_set(DKAPPS_DIR "${DKBRANCH_DIR}/DKApps")
		set(ENV{DKAPPS_DIR} "${DKBRANCH_DIR}/DKApps")
		#dk_printVar(DKAPPS_DIR)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_DKAPPS_DIR()
	dk_printVar(DKAPPS_DIR)
endfunction()
