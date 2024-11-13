#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_linkDir(path)
#
#	Add a directory to the compiler library paths
#
#	@path	The path to add to the compiler library paths
#
function(dk_linkDir path)
	dk_debugFunc()
	
	if(path IN_LIST DKLINKDIRS_LIST)
		continue()  # already in the list
	endif()
	#dk_append(DKLINKDIRS_LIST ${item})
	dk_append(DKLINKDIRS_LIST ${path})
	#link_directories(${item})
	link_directories(${path})
endfunction()
dk_createOsMacros("dk_linkDir")




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()