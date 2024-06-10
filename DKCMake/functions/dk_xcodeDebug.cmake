include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_xcodeDebug(path) #target
#
#	TODO
#
#	@path				- TODO
#	@target:(optional)	- TODO
#
function(dk_xcodeDebug path)
	dk_debugFunc(${ARGV})
	
	if(NOT MAC_HOST)
		return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_error("dk_xcodeDebug(${path}) path does not exist")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Debug build WORKING_DIRECTORY ${path}/${OS})
		else()
			dk_executeProcess(xcodebuild -configuration Debug build WORKING_DIRECTORY ${path}/${OS})
		endif()
	endif()
endfunction()
dk_createOsMacros("dk_xcodeDebug" "NO_DEBUG_RELEASE_TAGS")




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)