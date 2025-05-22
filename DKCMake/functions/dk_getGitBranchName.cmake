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
# dk_getGitBranchName(url rtn_var)
#
#	Return the name of the head branch from a git repository
#
#	@url	- The git url
#	@rtn_var	- Returns the name of the head branch
#
#	https://stackoverflow.com/a/31919435
#
function(dk_getGitBranchName url rtn_var)
	dk_debugFunc()
	
	dk_depend(git)
			
	execute_process(COMMAND ${GIT_EXE} ls-remote ${url} heads/* RESULT_VARIABLE result OUTPUT_VARIABLE gitBranchName)
	set(${rtn_var} ${gitBranchName} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_getGitBranchName(todo)
endfunction()