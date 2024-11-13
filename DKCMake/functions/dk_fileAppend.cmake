#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_fileAppend(filepath, string)
#
#
function(dk_fileAppend filepath str) 
	dk_debugFunc()
	
	file(APPEND ${filepath} "${str}")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_fileAppend("dk_fileAppend_TEST.txt" "string written by dk_fileAppend")
endfunction()