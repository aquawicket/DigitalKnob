#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	
	dk_getParameter(RECURSE)

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