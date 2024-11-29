#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_addSource(<regex>)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_addSource)
	dk_debugFunc(1)
	
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGN})
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_addSource("todo")
endfunction()
