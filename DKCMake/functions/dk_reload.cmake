#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_reload()
#
#
function(dk_reload)
	dk_debugFunc()

<<<<<<< HEAD
	if(NOT EXISTS "${DKSCRIPT_PATH}")
		dk_fatal("DKSCRIPT_PATH:${DKSCRIPT_PATH} does not exist")
=======
	if(NOT EXISTS "$ENV{DKSCRIPT_PATH}")
		dk_fatal("DKSCRIPT_PATH:$ENV{DKSCRIPT_PATH} does not exist")
>>>>>>> Development
		dk_return()
	endif()
	
	dk_clearScreen()
<<<<<<< HEAD
	dk_info ("reloading ${DKSCRIPT_PATH}. . .")

	###### Method 1 ######
	dk_fileWrite("${DKCMAKE_DIR}/reload" "${DKSCRIPT_PATH}")
=======
	dk_info ("reloading $ENV{DKSCRIPT_PATH}. . .")

	###### Method 1 ######
	dk_fileWrite("$ENV{DKCMAKE_DIR}/reload" "$ENV{DKSCRIPT_PATH}")
>>>>>>> Development
	dk_exit(0)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_pause("Press any key to test dk_reload")
	dk_reload()
endfunction()