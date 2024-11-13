#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DKIMPORTS_DIR()
#
#
function(dk_DKIMPORTS_DIR)
	dk_debugFunc()
	
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	
		dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
		set(ENV{DKIMPORTS_DIR} "${DK3RDPARTY_DIR}/_DKIMPORTS")
		#dk_printVar(DKIMPORTS_DIR)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_DKIMPORTS_DIR()
	dk_printVar(DKIMPORTS_DIR)
endfunction()
