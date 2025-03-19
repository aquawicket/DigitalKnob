#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_reload()
#
#
function(dk_reload)
	dk_debugFunc()

	if(NOT EXISTS "$ENV{DKSCRIPT_PATH}")
		dk_fatal("DKSCRIPT_PATH:$ENV{DKSCRIPT_PATH} does not exist")
		dk_return()
	endif()
	
	dk_clearScreen()
	dk_info ("reloading $ENV{DKSCRIPT_PATH}. . .")

	###### Method 1 ######
	dk_fileWrite("$ENV{DKCMAKE_DIR}/reload" "$ENV{DKSCRIPT_PATH}")
	dk_exit(0)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_pause("Press any key to test dk_reload")
	dk_reload()
endfunction()