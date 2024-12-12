#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_group()
#
#
function(dk_group)
	dk_debugFunc(0)
  
	if(NOT DEFINED group_level)
		dk_set(group_level 0)
	else()
		math(EXPR group_level "${group_level}+1")
	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_log("before dk_group()")
	dk_group()
	dk_log("inside group ${group_level}")
	dk_groupEnd()
	dk_log("after dk_group()")
endfunction()
