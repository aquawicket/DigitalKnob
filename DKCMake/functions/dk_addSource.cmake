#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_addSource(<regex>)
#
#	Add a file or file pattern to the SRC_INCLUDE list variable
#
function(dk_addSource)
	dk_debugFunc(1)
	
	set(regex ${ARGV})
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${regex})
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_addSource("todo")
endfunction()
