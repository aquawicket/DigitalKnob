include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

if(NOT DEFINED PAUSE_ON_EXIT) 
	set(PAUSE_ON_EXIT 1 CACHE INTERNAL "")
endif()
###############################################################################
# dk_exit(exit_code)
#
#	Exit cmake
#
function(dk_exit) # exit_code)
	dk_debugFunc(${ARGV})
	
	if(NOT ARGV0)
		set(exit_code 0)        ## default exit code is 0
	else()
		set(exit_code ${ARGV0})
	endif()
	
	dk_echo("dk_exit ${exit_code}")
	if(PAUSE_ON_EXIT EQUAL 1)
		dk_echo("*** PAUSE_ON_EXIT ***")
		dk_pause()
	endif()
	
	cmake_language(EXIT ${exit_code})  # => 3.29
	if(UNIX)
		execute_process(COMMAND killall -9 cmake)
	else()
		execute_process(COMMAND taskkill /IM cmake.exe /F)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	#dk_exit()
	#dk_exit(0)
	dk_exit(123)
endfunction()
