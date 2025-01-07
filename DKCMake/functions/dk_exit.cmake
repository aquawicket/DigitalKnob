#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

if(NOT DEFINED PAUSE_ON_EXIT) 
	set(PAUSE_ON_EXIT 1 CACHE INTERNAL "")
endif()
###############################################################################
# dk_exit(exit_code)
#
#	Exit cmake
#
function(dk_exit) # exit_code)
	dk_debugFunc()
	
	if(NOT exit_code)
		set(exit_code 0 CACHE INTERNAL "")
	endif()
	if(${ARGV0} GREATER ${exit_code})
		set(exit_code ${ARGV0})
	endif()
	
	if(PAUSE_ON_EXIT)
		dk_echo("*** PAUSE_ON_EXIT exit_code:${exit_code} ***")
		dk_pause()
	endif()
	
	if(CMAKE_SCRIPT_MODE_FILE)
		cmake_language(EXIT ${exit_code})  # => 3.29
	endif()
	
	### fallback methods ###
	if(UNIX)
		execute_process(COMMAND killall -9 cmake)
	else()
		execute_process(COMMAND taskkill /IM cmake.exe /F)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	#dk_exit()
	#dk_exit(0)
	dk_exit(13)
endfunction()
