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

# FIXME:  not working
###############################################################################
# dk_getFilename(path rtn_var)
#
#	Get the filename portion of a path
#
#	@path		- The path to use
#	@rtn_var:	- Returns the file name upon success: False upon error
#
function(dk_getFilename path rtn_var)
	dk_debugFunc()
	
	dk_assertVar(path)
	dk_assertVar(rtn_var)
	
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		dk_fatal("No Path Dividers found")
	endif()
	MATH(EXPR index "${index}+1")
	string(LENGTH ${path} length)
	if(${index} EQUAL ${length})
		dk_warning("dk_getFilename(${path}) last character in path was a /")
	endif()
	
	string(SUBSTRING ${path} ${index} -1 filename) 
	
	if(NOT filename)
		dk_warning("dk_getFilename(${path}) failed: Now using dk_basename() to retrieve the filename")
		dk_basename("${path}" filename)
	endif()
	
	dk_assertVar(filename)
	#dk_printVar(filename)
    set(${rtn_var} ${filename} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()