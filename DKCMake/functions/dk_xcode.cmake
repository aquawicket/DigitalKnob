#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

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





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_todo()
endfunction()