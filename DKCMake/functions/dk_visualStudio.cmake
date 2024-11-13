#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_visualStudio(path sln_file)
#
#	TODO
#
#	@args	- TODO
#
function(dk_visualStudio)
	dk_debugFunc()
	
	dk_visualStudioDebug(${ARGV})
	dk_visualStudioRelease(${ARGV})
endfunction()
dk_createOsMacros("dk_visualStudio" "NO_DEBUG_RELEASE_TAGS")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()