#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
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
	dk_debugFunc()
	
	if(NOT MAC_HOST)
		dk_return()
	endif()
	
	if(NOT EXISTS ${path})
		dk_fatal("dk_xcodeDebug(${path}) path does not exist")
	endif()
	
	if(RELEASE AND QUEUE_BUILD)
		if(${ARGC} GREATER 1)
			dk_exec(xcodebuild -target ${ARGV1} -configuration Release build WORKING_DIRECTORY ${path}/${Target_Tuple})
		else()
			dk_exec(xcodebuild -configuration Release build WORKING_DIRECTORY ${path}/${Target_Tuple})
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_todo()
endfunction()