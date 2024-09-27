#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_fileAppend(filepath, string)
#
#
function(dk_fileAppend filepath str) 
	dk_debugFunc("\${ARGV}")
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	file(APPEND ${filepath} "${str}")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_fileAppend("dk_fileAppend_TEST.txt" "string written by dk_fileAppend")
endfunction()