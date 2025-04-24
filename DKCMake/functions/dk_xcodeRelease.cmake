#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_xcodeRelease(path) #target
#
#	TODO
#
#	@path				- TODO
#	@target:(optional)	- TODO
#
function(dk_xcodeRelease path)
	dk_debugFunc()
	
	if(NOT MAC_HOST)
		dk_return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_xcodeDebug(${path}) path does not exist")
	endif()
	
	if(RELEASE AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
<<<<<<< HEAD
			dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${path}/${triple})
		else()
			dk_executeProcess(xcodebuild -configuration Release build WORKING_DIRECTORY ${path}/${triple})
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_xcodeRelease" "NO_DEBUG_RELEASE_TAGS")
=======
			dk_exec(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${path}/${target_triple})
		else()
			dk_exec(xcodebuild -configuration Release build WORKING_DIRECTORY ${path}/${target_triple})
		endif()
	endif()
endfunction()

>>>>>>> Development




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development

	dk_todo()
endfunction()