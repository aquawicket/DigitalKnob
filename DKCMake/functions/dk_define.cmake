#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

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
dk_createOsMacros("dk_define")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()
