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
function(dk_exit exit_code)
	dk_debugFunc(${ARGV})
	
	if(PAUSE_ON_EXIT EQUAL 1)
		dk_echo("*** PAUSE_ON_EXIT: exit_code:${exit_code} ***")
		dk_pause()
	endif()
	
	cmake_language(EXIT ${exit_code})  # => 3.29
	if(UNIX)
		execute_process(COMMAND killall -9 cmake)
	else()
		execute_process(COMMAND taskkill /IM cmake.exe /F)
	endif()
endfunction()





function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_exit(0)
endfunction()