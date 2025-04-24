#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##################################################################################
# dk_assertVar(variable)
#
#	If the variable compares equal to false (i.e., the variable is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@variable:  The variable to be evaluated. If this variable evaluates to false, this causes an assertion
#
<<<<<<< HEAD
function(dk_assertVar variable)
	dk_debugFunc()	
	
	if(NOT ${variable})
		dk_echo("\n\n${bg_red}Assertion failed: at ${variable}${clr}")
		dk_replaceAll("${variable}"  " "  ""  var)
		
		dk_printVar(CMAKE_SOURCE_DIR)
		dk_printVar(PROJECT_BINARY_DIR)
		dk_printVar(PROJECT_SOURCE_DIR)
		dk_printVar(CMAKE_TOOLCHAIN_FILE)
		dk_printVar(CMAKE_PARENT_LIST_FILE)
		dk_printVar(CMAKE_CURRENT_BINARY_DIR)
		dk_printVar(CMAKE_CURRENT_FUNCTION)
		dk_printVar(CMAKE_CURRENT_FUNCTION_LIST_DIR)
		dk_printVar(CMAKE_CURRENT_FUNCTION_LIST_FILE)
		dk_printVar(CMAKE_CURRENT_FUNCTION_LIST_LINE)
		dk_printVar(CMAKE_CURRENT_LIST_DIR)
		dk_printVar(CMAKE_CURRENT_LIST_FILE)
		dk_printVar(CMAKE_CURRENT_LIST_LINE)
		dk_printVar(CMAKE_SCRIPT_MODE_FILE)
		dk_printVar(CMAKE_CURRENT_SOURCE_DIR)
		dk_pause()
		
		if("${var}")
			dk_error("${bg_red} { \"${var}\" : \"${${var}}\" } ${clr}")
		else()
			dk_error("${bg_red} ${variable} ${clr}")
		endif()
	endif()

# DEBUG	
#	dk_printVar(${variable})
=======
function(dk_assertVar)
	dk_debugFunc(1)
	set(variable ${ARGV0})
	
	if(NOT DEFINED ${variable})
		dk_echo("\n\n${bg_red}Assertion failed: at ${variable}${clr}")
		
		if("${var}")
			dk_fatal("${bg_red}${white} { \"${var}\" : \"${${var}}\" } ${clr}")
		else()
			dk_fatal("${bg_red}${white} ${variable} ${clr}")
		endif()
	endif()
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_assertVar(todo) # TODO
>>>>>>> Development
endfunction()
