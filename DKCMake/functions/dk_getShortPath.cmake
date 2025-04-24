#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_getShortPath(path rtn_var)
#
#	TODO
#
#	@path		- TODO
#	@rtn_var		- TODO
#
function(dk_getShortPath path rtn_var)
	dk_debugFunc()
	
	if(WIN_HOST)
<<<<<<< HEAD
		dk_fileWrite(${DKCMAKE_DIR}/dk_getShortPath.cmd "@ECHO OFF \necho %~s1")
		execute_process(COMMAND ${DKCMAKE_DIR}/dk_getShortPath.cmd ${path} OUTPUT_VARIABLE shortPath WORKING_DIRECTORY ${DIGITALKNOB_DIR})
=======
		dk_fileWrite($ENV{DKCMAKE_DIR}/dk_getShortPath.cmd "@ECHO OFF \necho %~s1")
		execute_process(COMMAND $ENV{DKCMAKE_DIR}/dk_getShortPath.cmd ${path} OUTPUT_VARIABLE shortPath WORKING_DIRECTORY $ENV{DIGITALKNOB_DIR})
>>>>>>> Development
		dk_replaceAll(${shortPath} "\\" "/" shortPath)
		dk_replaceAll(${shortPath} "\n" "" shortPath)
		set(${rtn_var} ${shortPath} PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()