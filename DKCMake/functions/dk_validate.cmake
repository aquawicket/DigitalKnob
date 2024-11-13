#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_validate(variable "code")
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid. Like a function "dk_DIGITALKNOB_DIR()"
#
macro(dk_validate variable code)
	dk_debugFunc()
#	if(NOT ${ARGC} EQUAL 2)
#		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
#	endif()
	
#	if(NOT variable)
#		dk_warning("dk_append(${variable} ${code}) variable is invalid")
#		dk_return()
#	endif()
#	if(NOT code)
#		dk_warning("dk_append(${variable} ${code}) code is invalid")
#		dk_return()
#	endif()
	
	if(NOT DEFINED ${variable})
		dk_eval("${code}")
	endif()
	
	
	
	#dk_echo("${variable} = ${${variable}}")
	#dk_printVar(${variable})
endmacro()
#dk_createOsMacros("dk_validate")






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()
