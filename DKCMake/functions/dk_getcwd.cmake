#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################



#########################################################################
if(NOT PWD)
	dk_set(PWD "${CMAKE_CURRENT_LIST_DIR}")
endif()
#########################################################################
# dk_getcwd(path)
#
#	get working directory
#
function(dk_getcwd)
	dk_debugFunc(0)
	
	set(dk_getcwd "${PWD}" PARENT_SCOPE)
endfunction()











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_getcwd()
	dk_echo("dk_getcwd = '${dk_getcwd}'")
endfunction()
