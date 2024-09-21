include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_ndkRelease(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndkRelease path)
	dk_debugFunc("\${ARGV}")
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_ndkRelease(${path}) path does not exist")
	endif()
	
	if(RELEASE AND QUEUE_BUILD)
		if(WIN_HOST)
			dk_executeProcess(${ANDROID_NDK}/ndk-build.cmd WORKING_DIRECTORY ${path}/${triple}/Release)
		endif()
		if(UNIX_HOST)
			dk_executeProcess(${ANDROID_NDK}/ndk-build WORKING_DIRECTORY ${path}/${triple}/Release)
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_ndkRelease" "NO_DEBUG_RELEASE_TAGS")





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()