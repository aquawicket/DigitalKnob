include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_reload()
#
#
function(dk_reload)
	dk_debugFunc(${ARGV})

	if(NOT EXISTS "${DKSCRIPT_PATH}")
		dk_error("DKSCRIPT_PATH:${DKSCRIPT_PATH} does not exist")
		return()
	endif()
	
	dk_clearScreen()
	dk_info ("reloading ${DKSCRIPT_PATH}. . .")

	###### Method 1 ######
	dk_fileWrite("${DKCMAKE_DIR}/reload" "${DKSCRIPT_PATH}")
	dk_exit(0)
endfunction()



function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_pause()
	dk_reload()
endfunction()