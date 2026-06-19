#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
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
	
	if(DKDEFINES_LIST MATCHES -D${str})
		return() # already in the list
	endif()

	dk_append(DKDEFINES_LIST -D${str})
	dk_set(DKDEFINES_LIST "${DKDEFINES_LIST}")
#	set(ENV{DKDEFINES_LIST} "${DKDEFINES_LIST}")  # Export an enviromnent variable so the App's CMakeLists.txt can import it
	
#	if(CMAKE_SCRIPT_MODE_FILE)
#		if(DKScriptMode_Warnings)
#			dk_warning("add_definitions() not available in script mode")
#		endif()
#	else()
#		add_definitions(-D${str})
#	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_define(todo) #TODO
endfunction()
