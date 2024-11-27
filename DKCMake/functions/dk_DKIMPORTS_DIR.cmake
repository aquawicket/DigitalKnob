#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_DKIMPORTS_DIR()
#
#
function(dk_DKIMPORTS_DIR)
	dk_debugFunc(0 1)
	
	###### SET ######
	if(ARGN0)
		dk_set(DKIMPORTS_DIR "${ARGN0}")
		
	###### GET ######
	else()
		dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
		dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DKIMPORTS_DIR . . .")
	dk_DKIMPORTS_DIR()
	dk_printVar(DKIMPORTS_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKIMPORTS_DIR . . .")
	dk_DKIMPORTS_DIR("C:/DK/DKImports")
	dk_printVar(DKIMPORTS_DIR)
endfunction()
