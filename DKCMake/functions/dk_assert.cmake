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
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	if(NOT ${expression})
		message(STATUS "\n\n${bg_red}Assertion failed: at ${expression}${clr}")
		dk_replaceAll("${expression}"  " "  ""  var)
		
		if("${var}")
			message(FATAL_ERROR "${BLACK}${STACK_HEADER}${clr}${bg_red} { \"${var}\" : \"${${var}}\" } ${clr}")
		else()
			message(FATAL_ERROR "${BLACK}${STACK_HEADER}${clr}${bg_red} ${expression} ${clr}")
		endif()
		dk_exit() #FIXME:  is this needed?
	endif()
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()