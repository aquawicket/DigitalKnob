include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

##################################################################################
# dk_assert_path(path)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  The expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
function(dk_assert_path path)
	dk_debugFunc(${ARGV})
	
	if(NOT EXISTS ${path})
		message(STATUS "\n\n${BG_red}Assertion failed: at ${path}, ${STACK_HEADER}${clr}")
		string(REPLACE " " "" var "${path}")
		
		if("${var}")
			message(FATAL_ERROR "${H_black}${STACK_HEADER}${clr}${BG_red} { \"${var}\" : \"${${var}}\" } ${clr}")
		else()
			message(FATAL_ERROR "${H_black}${STACK_HEADER}${clr}${BG_red} ${path} ${clr}")
		endif()
		dk_exit() #FIXME:  is this needed?
	endif()
endfunction()







function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)