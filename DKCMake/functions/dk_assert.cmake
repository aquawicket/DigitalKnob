include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_assert(expression)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  The expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
function(dk_assert expression)
	dk_debugFunc("\${ARGV}")	
	
	if(NOT ${expression})
		dk_echo("\n\n${bg_red}Assertion failed: at ${expression}${clr}")
		dk_replaceAll("${expression}"  " "  ""  var)
		
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
			dk_error("${bg_red} ${expression} ${clr}")
		endif()
	endif()

# DEBUG	
#	dk_printVar(${expression})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()
