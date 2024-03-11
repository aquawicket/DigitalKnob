include_guard()

###############################################################################
# dk_getShortPath(path RESULT)
#
#	TODO
#
#	@path		- TODO
#	@RESULT		- TODO
#
function(dk_getShortPath path RESULT)
	DKDEBUGFUNC(${ARGV})
	if(WIN_HOST)
		file(WRITE ${DKCMAKE_DIR}/dk_getShortPath.cmd "@ECHO OFF \necho %~s1")
		execute_process(COMMAND ${DKCMAKE_DIR}/dk_getShortPath.cmd ${path} OUTPUT_VARIABLE path WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		string(REPLACE "\\" "/" path ${path})
		string(REPLACE "\n" "" path ${path})
		set(${RESULT} ${path} PARENT_SCOPE)
	endif()
endfunction()