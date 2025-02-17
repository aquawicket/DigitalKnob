#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
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
	dk_debugFunc()
	
	if(NOT MAC_HOST)
		dk_return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_xcodeDebug(${path}) path does not exist")
	endif()
	
	if(DEBUG AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			dk_executeProcess(xcodebuild -target ${ARGV1} -configuration Debug build WORKING_DIRECTORY ${path}/${target_triple})
		else()
			dk_executeProcess(xcodebuild -configuration Debug build WORKING_DIRECTORY ${path}/${target_triple})
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_todo()
endfunction()