#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_ndk(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndk)
	dk_debugFunc()
	
	dk_ndkDebug(${ARGV})
	dk_ndkRelease(${ARGV})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_ndk(todo) # TODO
endfunction()