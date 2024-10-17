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
function(dk_assertPath path)
	dk_debugFunc()
	dk_info("dk_assertPath(${ARGV})")
	
	dk_varToString(path path_value)
	#dk_debug("dk_assertPath(${path}) = ${path_value}")
	if(EXISTS "${path}" OR EXISTS "${${path}}")
		return()
	endif()
	
	dk_fatal("Assertion failed: Path Not Found ${path}:${path_value}  CMAKE_PARENT_LIST_FILE:${CMAKE_PARENT_LIST_FILE}")
		
#	dk_printVar(CMAKE_SOURCE_DIR)
#	dk_printVar(PROJECT_BINARY_DIR)
#	dk_printVar(PROJECT_SOURCE_DIR)
#	dk_printVar(CMAKE_TOOLCHAIN_FILE)
#	dk_printVar(CMAKE_PARENT_LIST_FILE)
#	dk_printVar(CMAKE_CURRENT_BINARY_DIR)
#	dk_printVar(CMAKE_CURRENT_FUNCTION)
#	dk_printVar(CMAKE_CURRENT_FUNCTION_LIST_DIR)
#	dk_printVar(CMAKE_CURRENT_FUNCTION_LIST_FILE)
#	dk_printVar(CMAKE_CURRENT_FUNCTION_LIST_LINE)
#	dk_printVar(CMAKE_CURRENT_LIST_DIR)
#	dk_printVar(CMAKE_CURRENT_LIST_FILE)
#	dk_printVar(CMAKE_CURRENT_LIST_LINE)
#	dk_printVar(CMAKE_SCRIPT_MODE_FILE)
#	dk_printVar(CMAKE_CURRENT_SOURCE_DIR)
#	dk_pause()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_assertPath("C:/Windows/System32")
	
	set(myPathVar "C:/Windows/System32")
	dk_assertPath(${myPathVar})
	dk_assertPath("${myPathVar}")
	dk_assertPath(myPathVar)
	dk_assertPath("C:/Non/Existent/path")
	
endfunction()
