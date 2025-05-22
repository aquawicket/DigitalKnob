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
# dk_linkDir(path)
#
#	Add a directory to the compiler library paths
#
#	@path	The path to add to the compiler library paths
#
function(dk_linkDir path)
	dk_debugFunc(1)
	
	if(path IN_LIST DKLINKDIRS_LIST)
		continue()  # already in the list
	endif()

	dk_append(DKLINKDIRS_LIST ${path})
	if(NOT CMAKE_SCRIPT_MODE_FILE)
		link_directories(${path})
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_linkDir(todo)
endfunction()