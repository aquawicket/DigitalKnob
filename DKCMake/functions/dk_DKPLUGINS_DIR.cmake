#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DKPLUGINS_DIR()
#
#
function(dk_DKPLUGINS_DIR)
	dk_debugFunc()
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	
		dk_set(DKPLUGINS_DIR "${DKBRANCH_DIR}/DKPlugins")
		set(ENV{DKPLUGINS_DIR} "${DKBRANCH_DIR}/DKPlugins")
		#dk_printVar(DKPLUGINS_DIR)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_DKPLUGINS_DIR()
	dk_printVar(DKPLUGINS_DIR)
endfunction()
