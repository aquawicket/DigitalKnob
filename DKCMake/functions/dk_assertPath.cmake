#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_assertPath(path)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  The expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
function(dk_assertPath)
	dk_debugFunc(1)

<<<<<<< HEAD
	set(path ${ARGV0})
	
	dk_varToString(path path_value)
	#dk_debug("dk_assertPath(${path}) = ${path_value}")
	if(EXISTS "${path}" OR EXISTS "${${path}}")
		return()
	endif()
	
	dk_fatal("Assertion failed: Path Not Found ${path}:${path_value}  CMAKE_PARENT_LIST_FILE:${CMAKE_PARENT_LIST_FILE}")

# DEBUG		
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
=======
	set(_path_ "${ARGV0}")
#	if(DEFINED ${_path_})
#		set(_path_ ${${_path_}})
#	endif()
	#dk_printVar(_path_)
	
	#dk_varToString(_path_ path_value)
	#dk_printVar(path_value)
	
	if((EXISTS "${_path_}") OR (EXISTS "${${_path_}}") OR (EXISTS "$ENV{_path_}"))
		return()
	endif()
		
	dk_fatal("${bg_red}${white}Assertion failed: Path Not Found path:'${_path_}:${${_path_}}'")

>>>>>>> Development
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_assertPath("C:/Windows/System32")
	
	set(myPathVar "C:/Windows/System32")
	dk_assertPath(${myPathVar})
	dk_assertPath("${myPathVar}")
	dk_assertPath(myPathVar)
<<<<<<< HEAD
	dk_assertPath("C:/Non/Existent/path")
=======
	
	set(myPathVarB "C:/NonExistentPath")
	#dk_assertPath(myPathVarB)
	dk_assertPath(myPathVarB)
>>>>>>> Development
endfunction()
