include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

##################################################################################
# DK_ASSERT(expression)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  The expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
function(DK_ASSERT expression)
	dk_debugFunc(${ARGV})
	
	if(NOT ${expression})
		#message(STATUS "\n\n${BG_red}Assertion failed: at ${expression}, ${STACK_HEADER}${clr}")
		message(STATUS "\n\n${BG_red}Assertion failed: at ${expression}${clr}")
		string(REPLACE " " "" var "${expression}")
		
		if("${var}")
			message(FATAL_ERROR "${H_black}${STACK_HEADER}${clr}${BG_red} { \"${var}\" : \"${${var}}\" } ${clr}")
		else()
			message(FATAL_ERROR "${H_black}${STACK_HEADER}${clr}${BG_red} ${expression} ${clr}")
		endif()
		dk_exit() #FIXME:  is this needed?
	endif()
endfunction()
