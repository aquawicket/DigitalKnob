#!/usr/bin/cmake -P
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
