#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_ndkRelease(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndkRelease path)
	dk_debugFunc()
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_ndkRelease(${path}) path does not exist")
	endif()
	
	if(RELEASE AND QUEUE_BUILD)
		if(WIN_HOST)
<<<<<<< HEAD
			dk_executeProcess(${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${path}/${triple}/Release)
		endif()
		if(UNIX_HOST)
			dk_executeProcess(${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${path}/${triple}/Release)
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_ndkRelease" "NO_DEBUG_RELEASE_TAGS")
=======
			dk_exec(${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${path}/${target_triple}/Release)
		endif()
		if(UNIX_HOST)
			dk_exec(${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${path}/${target_triple}/Release)
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