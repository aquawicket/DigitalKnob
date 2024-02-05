include_guard()

##################################################################################
# DKASSERT(expression)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  Expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
macro(DKASSERT expression)
	#DKDEBUGFUNC(${ARGV})
	if(expression)
		return()
	endif()
	
	message(STATUS "Assertion failed: ${expression}, ${STACK_HEADER}")
	string(REPLACE " " "" var ${msg})
	dk_updateLogInfo()
	if(${var})
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red} { \"${var}\" : \"${${var}}\" } ${CLR}")
	else()
		message(FATAL_ERROR "${H_black}${STACK_HEADER}${CLR}${BG_red} ${msg} ${CLR}")
	endif()
	dk_exit() #FIXME:  is this needed?
endmacro()
