#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

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
<<<<<<< HEAD
dk_createOsMacros("dk_ndk" "NO_DEBUG_RELEASE_TAGS")
=======

>>>>>>> Development






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_ndk(todo) # TODO
>>>>>>> Development
endfunction()