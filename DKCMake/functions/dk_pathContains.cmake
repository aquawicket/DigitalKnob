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
# dk_pathContains(expression rtn_var)
#
#	@expression	- The search expression to use. Example: "${path}/subfolder/*.exe"
#   @rtn_var		- Returns TRUE if the expression is found
#
function(dk_pathContains expression rtn_var)
	dk_debugFunc()
	
	file(GLOB glob_var "${expression}")
	if(glob_var)
		set(${pathContains} TRUE)
	endif()
	
	#dk_printVar(pathContains)
	set(${rtn_var} ${pathContains} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()