#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_validate(variable "code")
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid. Like a function "dk_DIGITALKNOB_DIR()"
#
<<<<<<< HEAD
macro(dk_validate variable code)
	dk_debugFunc()
#	if(NOT ${ARGC} EQUAL 2)
#		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
#	endif()
	
=======
function(dk_validate)# variable code)
	dk_debugFunc(1 2)

>>>>>>> Development
#	if(NOT variable)
#		dk_warning("dk_append(${variable} ${code}) variable is invalid")
#		dk_return()
#	endif()
#	if(NOT code)
#		dk_warning("dk_append(${variable} ${code}) code is invalid")
#		dk_return()
#	endif()
	
<<<<<<< HEAD
	if(NOT DEFINED ${variable})
		dk_eval("${code}")
	endif()
	
	
	
	#dk_echo("${variable} = ${${variable}}")
	#dk_printVar(${variable})
endmacro()
#dk_createOsMacros("dk_validate")
=======
	if(NOT DEFINED ${ARGV0})
		dk_eval("${ARGV1}")
	endif()
	
	#dk_echo("${variable} = ${${variable}}")
	#dk_printVar(${variable})
endfunction()

>>>>>>> Development






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()
