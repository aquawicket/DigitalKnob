include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_assertPath(path)
#
#	If the expression compares equal to false (i.e., the expression is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@expression:  The expression to be evaluated. If this expression evaluates to false, this causes an assertion
#
function(dk_assertPath path)
	dk_debugFunc(${ARGV})
	
	if(NOT EXISTS ${path})
		dk_echo("\n\n${bg_red}Assertion failed: at ${path}, ${STACK_HEADER}${clr}")
		dk_replaceAll("${path}"  " "  ""  var)
		
		if("${var}")
			dk_error("${bg_red} { \"${var}\" : \"${${var}}\" } ${clr}")
		else()
			dk_error("${bg_red} ${path} ${clr}")
		endif()
		dk_exit(1)
	endif()
endfunction()







function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_assertPath("C:/Windows/System32")
endfunction()
