#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
			dk_executeProcess(${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${path}/${target_triple}/Release)
		endif()
		if(UNIX_HOST)
			dk_executeProcess(${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${path}/${target_triple}/Release)
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()