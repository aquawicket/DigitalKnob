#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_findFiles(path pattern rtn_var) RECURSE
#
#	Search for files within a path matching a pattern
#
#	@path				- The path to search 
#	@pattern			- The pattern to search for
#	@rtn_var				- Returns the list of file(s) if found
#   RECURSE (optional) 	- Search the path recursivly 
#
function(dk_findFiles path pattern rtn_var)
	dk_debugFunc()
	
	dk_getOption(RECURSE)

	if(RECURSE)
		file(GLOB_RECURSE findFiles "${path}/" "${path}/${pattern}")
	else()
		file(GLOB findFiles "${path}/" "${path}/${pattern}")
	endif()
	if(NOT findFiles)
		dk_fatal("findFiles is invalid")
		return()
	endif()
	#dk_printVar(findFiles)
	set(${rtn_var} ${findFiles} PARENT_SCOPE)
	#dk_printVar(rtn_var)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()