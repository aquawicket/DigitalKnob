#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_addSource(<regex>)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_addSource regex)
	dk_debugFunc("\${ARGV}")
	
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
	
# DEBUG
#	TODO
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_addSource()
endfunction()
