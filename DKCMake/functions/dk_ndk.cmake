#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_ndk(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndk)
	dk_debugFunc("\${ARGV}")
	
	dk_ndkDebug(${ARGV})
	dk_ndkRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_ndk" "NO_DEBUG_RELEASE_TAGS")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()