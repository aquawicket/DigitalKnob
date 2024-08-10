include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

if(NOT DEFINED PAUSE_ON_EXIT) 
	set(PAUSE_ON_EXIT 1 CACHE INTERNAL "")
endif()
###############################################################################
# dk_exit()
#
#	Exit cmake
#
function(dk_exit)
	dk_debugFunc(${ARGV})
	
	message("#################### dk_exit() ####################")
	if(PAUSE_ON_EXIT EQUAL 1)
		dk_echo("*** PAUSE_ON_EXIT ***")
		dk_pause()
	endif()
	if(WIN32)
		execute_process(COMMAND taskkill /IM cmake.exe /F)
	else()
		execute_process(COMMAND killall -9 cmake)
	endif()
endfunction()





function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_exit()
endfunction()