include(${DKCMAKE_DIR}/functions/DK.cmake)
include_guard()

##################################################################################
# DK_ASSERT_PATH(path)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  The expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
function(DK_ASSERT_PATH path)
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

	#dk_todo()

endfunction()
