include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
	dk_debugFunc(${ARGV})
	
	dk_xcodeDebug(${ARGV})
	dk_xcodeRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_xcode" "NO_DEBUG_RELEASE_TAGS")