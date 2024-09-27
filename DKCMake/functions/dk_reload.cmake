#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_reload()
#
#
function(dk_reload)
	dk_debugFunc("\${ARGV}")

	if(NOT EXISTS "${DKSCRIPT_PATH}")
		dk_fatal("DKSCRIPT_PATH:${DKSCRIPT_PATH} does not exist")
		return()
	endif()
	
	dk_clearScreen()
	dk_info ("reloading ${DKSCRIPT_PATH}. . .")

	###### Method 1 ######
	dk_fileWrite("${DKCMAKE_DIR}/reload" "${DKSCRIPT_PATH}")
	dk_exit(0)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_pause("Press any key to test dk_reload")
	dk_reload()
endfunction()