include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_reload()
#
#
function(dk_reload)
	dk_debugFunc(${ARGV})

	dk_info("reloading ${DKSCRIPT_NAME}. . .")
	dk_fileWrite(${DKCMAKE_DIR}/reload "${DKSCRIPT_PATH}")
	dk_exit(0)
endfunction()



function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_pause()
	dk_reload()
endfunction()