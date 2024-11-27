#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

##################################################################################
# dk_assertPath(path)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  The expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
function(dk_assertPath)
	dk_debugFunc(1)

	set(_path_ "${ARGV0}")
	dk_printVar(_path_)
	
	dk_varToString(_path_ path_value)
	dk_printVar(path_value)
	
	if(EXISTS "${_path_}" OR EXISTS "${${_path_}}")
		return()
	endif()
	
	dk_fatal("${bg_red}${white}Assertion failed: Path Not Found path:'${_path_}'")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_assertPath("C:/Windows/System32")
	
	set(myPathVar "C:/Windows/System32")
	dk_assertPath(${myPathVar})
	dk_assertPath("${myPathVar}")
	dk_assertPath(myPathVar)
	dk_assertPath("C:/Non/Existent/path")
endfunction()
