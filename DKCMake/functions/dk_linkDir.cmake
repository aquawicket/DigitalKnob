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
	dk_set(DKLINKDIRS_LIST "${DKLINKDIRS_LIST}")
#	set(ENV{DKLINKDIRS_LIST} "${DKLINKDIRS_LIST}")  # Export an enviromnent variable so the App's CMakeLists.txt can import it
	
#	if(CMAKE_SCRIPT_MODE_FILE)
#		dk_warning("link_directories() not available in script mode")
#	else()
#		link_directories(${path})
#	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_linkDir(todo)
endfunction()