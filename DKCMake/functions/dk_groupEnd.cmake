#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_groupEnd()
#
#
function(dk_groupEnd)
	dk_debugFunc(0)
  
	if(NOT DEFINED group_level)
		dk_set(group_level 0)
	else()
		math(EXPR group_level "${group_level}-1")
	endif()
	set(group_level ${group_level} PARENT_SCOPE)
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
