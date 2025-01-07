#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

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
		dk_fileWrite(${DKCMAKE_DIR}/dk_getShortPath.cmd "@ECHO OFF \necho %~s1")
		execute_process(COMMAND ${DKCMAKE_DIR}/dk_getShortPath.cmd ${path} OUTPUT_VARIABLE shortPath WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		dk_replaceAll(${shortPath} "\\" "/" shortPath)
		dk_replaceAll(${shortPath} "\n" "" shortPath)
		set(${rtn_var} ${shortPath} PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()