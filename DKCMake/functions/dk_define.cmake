#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
<<<<<<< HEAD
dk_createOsMacros("dk_define")
=======
>>>>>>> Development





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_define(todo) #TODO
>>>>>>> Development
endfunction()
