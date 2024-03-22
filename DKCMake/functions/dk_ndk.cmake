include_guard()

###############################################################################
# dk_ndk(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndk)
	DKDEBUGFUNC(${ARGV})
	dk_ndkDebug(${ARGV})
	dk_ndkRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_ndk" "NO_DEBUG_RELEASE_TAGS")