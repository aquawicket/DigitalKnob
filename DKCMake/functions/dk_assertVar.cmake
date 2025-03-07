#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

##################################################################################
# dk_assertVar(variable)
#
#	If the variable compares equal to false (i.e., the variable is false), a error message is written and abort is called, terminating the scripts execution.
#
#	@variable:  The variable to be evaluated. If this variable evaluates to false, this causes an assertion
#
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
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_assertVar(todo) # TODO
endfunction()
