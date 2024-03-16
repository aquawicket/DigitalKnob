include_guard()

###############################################################################
# dk_xcodeRelease(path) #target
#
#	TODO
#
#	@path				- TODO
#	@target:(optional)	- TODO
#
function(dk_xcodeRelease path)
	DKDEBUGFUNC(${ARGV})
	if(NOT MAC_HOST)
		return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_error("dk_xcodeDebug(${path}) path does not exist")
	endif()
	
	if(RELEASE AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${path}/${OS})
		else()
			dk_executeProcess(xcodebuild -configuration Release build WORKING_DIRECTORY ${path}/${OS})
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_xcodeRelease" "NO_DEBUG_RELEASE_TAGS")