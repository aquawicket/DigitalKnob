#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_fileAppend(filepath, string)
#
#
function(dk_fileAppend filepath str) 
	dk_debugFunc()
<<<<<<< HEAD
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
=======
>>>>>>> Development
	
	file(APPEND ${filepath} "${str}")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_fileAppend("dk_fileAppend_TEST.txt" "string written by dk_fileAppend")
endfunction()