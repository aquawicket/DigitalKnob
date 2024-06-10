include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_ndk(path)
#
#	TODO
#
#	@path		- TODO
#
function(dk_ndk)
	dk_debugFunc(${ARGV})
	
	dk_ndkDebug(${ARGV})
	dk_ndkRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_ndk" "NO_DEBUG_RELEASE_TAGS")






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)