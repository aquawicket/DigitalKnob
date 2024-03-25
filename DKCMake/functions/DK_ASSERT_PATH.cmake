include_guard()

##################################################################################
# DK_ASSERT_PATH(path)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  The expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
macro(DK_ASSERT_PATH path)
	#DKDEBUGFUNC(${ARGV})
	
	if(NOT EXISTS ${path})
		message(STATUS "\n\n${BG_red}Assertion failed: at ${path}, ${STACK_HEADER}${CLR}")
		string(REPLACE " " "" var "${path}")
		
		if("${var}")
			message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red} { \"${var}\" : \"${${var}}\" } ${CLR}")
		else()
			message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red} ${path} ${CLR}")
		endif()
		dk_exit() #FIXME:  is this needed?
	endif()
endmacro()
