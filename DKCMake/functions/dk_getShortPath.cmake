include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getShortPath(path rtn_var)
#
#	TODO
#
#	@path		- TODO
#	@rtn_var		- TODO
#
function(dk_getShortPath path rtn_var)
	dk_debugFunc(${ARGV})
	
	if(WIN_HOST)
		dk_fileWrite(${DKCMAKE_DIR}/dk_getShortPath.cmd "@ECHO OFF \necho %~s1")
		execute_process(COMMAND ${DKCMAKE_DIR}/dk_getShortPath.cmd ${path} OUTPUT_VARIABLE shortPath WORKING_DIRECTORY ${DIGITALKNOB_DIR})
		dk_replaceAll(${shortPath} "\\" "/" shortPath)
		dk_replaceAll(${shortPath} "\n" "" shortPath)
		set(${rtn_var} ${shortPath} PARENT_SCOPE)
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()