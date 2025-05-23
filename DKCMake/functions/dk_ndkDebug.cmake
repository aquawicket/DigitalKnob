#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_ndkDebug(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndkDebug path)
	dk_debugFunc()
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_ndkDebug(${path}) path does not exist")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		if(WIN_HOST)
			dk_exec(${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${path}/${target_triple}/Debug)
		endif()
		if(UNIX_HOST)
			dk_exec(${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${path}/${target_triple}/Debug)
		endif()
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()