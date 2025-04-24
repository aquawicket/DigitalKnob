#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_linkDir(path)
#
#	Add a directory to the compiler library paths
#
#	@path	The path to add to the compiler library paths
#
function(dk_linkDir path)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(1)
>>>>>>> Development
	
	if(path IN_LIST DKLINKDIRS_LIST)
		continue()  # already in the list
	endif()
<<<<<<< HEAD
	#dk_append(DKLINKDIRS_LIST ${item})
	dk_append(DKLINKDIRS_LIST ${path})
	#link_directories(${item})
	link_directories(${path})
endfunction()
dk_createOsMacros("dk_linkDir")
=======

	dk_append(DKLINKDIRS_LIST ${path})
	if(NOT CMAKE_SCRIPT_MODE_FILE)
		link_directories(${path})
	endif()
endfunction()
>>>>>>> Development




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_linkDir(todo)
>>>>>>> Development
endfunction()