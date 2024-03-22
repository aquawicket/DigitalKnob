include_guard()

###############################################################################
# dk_visualStudio(path sln_file)
#
#	TODO
#
#	@args	- TODO
#
function(dk_visualStudio)
	DKDEBUGFUNC(${ARGV})
	dk_visualStudioDebug(${ARGV})
	dk_visualStudioRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_visualStudio" "NO_DEBUG_RELEASE_TAGS")