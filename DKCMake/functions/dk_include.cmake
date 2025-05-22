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
# dk_include(path) variable
#
#	Add a directory to the compiler include paths
#
#	@path					- The path to add to the compiler include paths
#   @variable (optional)	- Create a variable to store the path in.
#
function(dk_include path)
	dk_debugFunc(1 2)
	
	if(NOT EXISTS "${path}")
		dk_warning("dk_include(): path:${path} does not exist")
	endif()
	
	if(DKINCLUDES_LIST MATCHES "${path}")
		dk_return()	# path is already in the list
	endif()
		
	if(INSTALL_DKLIBS)
		dk_basename(${CMAKE_CURRENT_LIST_DIR} LIB_NAME)
		file(INSTALL DIRECTORY ${path}/ DESTINATION ${CMAKE_INSTALL_PREFIX}/include/${LIB_NAME} FILES_MATCHING PATTERN "*.h")
		dk_deleteEmptyDirectories(${CMAKE_INSTALL_PREFIX}/include/${LIB_NAME})
	endif()
		
	dk_append(DKINCLUDES_LIST ${path})
	if(CMAKE_SCRIPT_MODE_FILE)
		dk_warning("include_directories() cannot run in script mode.")
	else()
		include_directories(${path})
	endif()
		
	if(ARGV1)
		dk_set(${ARGV1} ${path}) # add the path to the supplied variable
	endif()

endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_include("TODO")
endfunction()