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
# dk_define(str)
#
#	TODO
#
#	@str	- TODO
#
function(dk_define str)
	dk_debugFunc()
	
	if(dkdefines_list MATCHES "${str}")
		return() # already in the list
	endif()

	dk_append(dkdefines_list ${str})
	dk_set(dkdefines_list "${dkdefines_list}")
	
	if(CMAKE_SCRIPT_MODE_FILE)
		dk_warning("add_definitions() not available in script mode")
	else()
		add_definitions(-D${str})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_define(todo) #TODO
endfunction()
