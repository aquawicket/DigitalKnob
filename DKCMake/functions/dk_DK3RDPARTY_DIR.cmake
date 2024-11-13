#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
function(dk_DK3RDPARTY_DIR)
	dk_debugFunc()
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	
		dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
		set(ENV{DK3RDPARTY_DIR} "${DKBRANCH_DIR}/3rdParty")
		#dk_printVar(DK3RDPARTY_DIR)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_DK3RDPARTY_DIR()
	dk_printVar(DKBRANCH_DIR)
endfunction()
