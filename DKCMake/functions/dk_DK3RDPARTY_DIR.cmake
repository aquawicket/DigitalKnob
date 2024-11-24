#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
function(dk_DK3RDPARTY_DIR)
	dk_debugFunc()
	
	if(ARGV0)
		dk_set(DK3RDPARTY_DIR "${ARGV0}")
	else()
		dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_DK3RDPARTY_DIR()
	dk_printVar(DK3RDPARTY_DIR)
endfunction()
