#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_xcode(args) #target
#
#	TODO
#
#	@args				- TODO
#	@target:(optional)	- TODO
#
function(dk_xcode)
	dk_debugFunc()
	
	dk_xcodeDebug(${ARGV})
	dk_xcodeRelease(${ARGV})
endfunction()
<<<<<<< HEAD
dk_createOsMacros("dk_xcode" "NO_DEBUG_RELEASE_TAGS")
=======

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