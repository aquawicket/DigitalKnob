#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DKPLUGINS_DIR()
#
#
function(dk_DKPLUGINS_DIR)
	dk_debugFunc()
	
	###### SET ######
	if(ARGV0)
		dk_set(DKPLUGINS_DIR "${ARGV0}")
		
	###### GET ######
	else()
		dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		dk_set(DKPLUGINS_DIR "${DKBRANCH_DIR}/DKPlugins")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_DKPLUGINS_DIR()
	dk_printVar(DKPLUGINS_DIR)
endfunction()
