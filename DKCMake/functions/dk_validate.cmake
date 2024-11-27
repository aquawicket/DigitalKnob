#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_validate(variable "code")
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid. Like a function "dk_DIGITALKNOB_DIR()"
#
function(dk_validate)# variable code)
	dk_debugFunc(1 2)

#	if(NOT variable)
#		dk_warning("dk_append(${variable} ${code}) variable is invalid")
#		dk_return()
#	endif()
#	if(NOT code)
#		dk_warning("dk_append(${variable} ${code}) code is invalid")
#		dk_return()
#	endif()
	
	if(NOT DEFINED ${ARGV0})
		dk_eval("${ARGV1}")
	endif()
	
	#dk_echo("${variable} = ${${variable}}")
	#dk_printVar(${variable})
endfunction()
#dk_createOsMacros("dk_validate")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
