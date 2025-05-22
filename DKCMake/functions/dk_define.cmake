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

###############################################################################
# dk_define(str)
#
#	TODO
#
#	@str	- TODO
#
function(dk_define str)
	dk_debugFunc()
	
	if(CMAKE_SCRIPT_MODE_FILE)
		return()
	endif()
	if(DKDEFINES_LIST MATCHES "${str}")
		return() # already in the list
	endif()

	dk_append(DKDEFINES_LIST ${str})
	add_definitions(-D${str})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_define(todo) #TODO
endfunction()
