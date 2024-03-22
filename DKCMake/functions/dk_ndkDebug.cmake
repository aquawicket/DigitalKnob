include_guard()

###############################################################################
# dk_ndkDebug(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndkDebug path)
	DKDEBUGFUNC(${ARGV})
	
	if(NOT EXISTS ${path})
		dk_error("dk_ndkDebug(${path}) path does not exist")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		if(WIN_HOST)
			dk_executeProcess(${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${path}/${OS}/Debug)
		endif()
		if(UNIX_HOST)
			dk_executeProcess(${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${path}/${OS}/Debug)
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_ndkDebug" "NO_DEBUG_RELEASE_TAGS")