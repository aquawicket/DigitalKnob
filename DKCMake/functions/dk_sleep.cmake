#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_sleep(seconds)
#
#	TODO
#
function(dk_sleep seconds)
	dk_debugFunc()
	
	if(ARGN)
		dk_info("...${ARGN}")
	endif()
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep ${seconds})
endfunction(dk_sleep)




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_sleep(5)
endfunction()
