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

##################################################################################
# dk_dirname(path, rtn_var)
#
#	Get the directory portion of a path
#
#	@path		- The path to use
#	@rtn_var	- Returns the directory upon success: False upon error
#
#   Reference	- https://en.wikipedia.org/wiki/Dirname
#
function(dk_dirname)
	dk_debugFunc(2)
	set(path ${ARGV0})
	set(rtn_var ${ARGV1})
	
	get_filename_component(dirname "${path}" DIRECTORY)
	set(${rtn_var} "${dirname}" PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	dk_dirname("C:/Windows/System32" dirname)
	dk_info("dirname = ${dirname}")
endfunction()