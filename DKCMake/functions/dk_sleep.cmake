#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_sleep(seconds)
#
#	TODO
#
<<<<<<< HEAD
function(dk_sleep seconds)
	dk_debugFunc()
	
	if(ARGN)
		dk_info("...${ARGN}")
	endif()
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep ${seconds})
endfunction(dk_sleep)
=======
function(dk_sleep)
	dk_debugFunc()
	
	set(seconds ${ARGV0})
	execute_process(COMMAND ${CMAKE_COMMAND} -E sleep ${seconds})
endfunction()
>>>>>>> Development




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_sleep(5)
=======
	dk_debugFunc(0)
	
	dk_sleep(3)
>>>>>>> Development
endfunction()
