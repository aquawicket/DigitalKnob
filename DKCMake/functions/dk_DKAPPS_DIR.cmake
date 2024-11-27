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
	if(ARGN)
		dk_set(DKAPPS_DIR "${ARGN}")
		
	###### GET ######
	else()
		dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		dk_set(DKAPPS_DIR "${DKBRANCH_DIR}/DKApps")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DKAPPS_DIR . . .")
	dk_DKAPPS_DIR()
	dk_printVar(DKAPPS_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKAPPS_DIR . . .")
	dk_DKAPPS_DIR("C:/DK/DKApps")
	dk_printVar(DKAPPS_DIR)
endfunction()
