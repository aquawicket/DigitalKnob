#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_sleep(seconds)
#
#	TODO
#
function(dk_sleep)
	dk_debugFunc()
	
	set(seconds ${ARGV0})
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep ${seconds})
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_sleep(5)
endfunction()
