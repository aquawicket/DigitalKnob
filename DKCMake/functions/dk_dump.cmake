#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

##############################################################################
# dk_dump(variable)
# 
#	Print the contents of a variable to the screen
#
#	@variable	- The variable to print to the screen. Without variable brackets ${ }'
#
macro(dk_dump variable)
	dk_debugFunc()
	
	dk_echo(STATUS "\n${cyan}############################### Variable DUMP ##############################################${clr}")	
	if(CMAKE_CURRENT_FUNCTION_LIST_FILE)
		dk_basename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
	endif()
	if(NOT DEFINED ${variable})
		dk_fatal("variable not defined. The syntax may be incorrect if using brackets - > \$ { variable } ")
		dk_info("${clr}${green} dk_dump(variable): <- CORRECT SYNTAX")
	else()
		dk_info("${FILENAME}:${CMAKE_CURRENT_FUNCTION_LIST_LINE} -> ${CMAKE_CURRENT_FUNCTION}(${ARGV})")
		list(LENGTH ${variable} variableLength)
		if(${variableLength} GREATER 1)
			set(variableType "list")
		elseif(variable MATCHES "^[0-9]+$")
			set(variableType "number")
		else()
			set(variableType "string")
		endif()
		dk_echo("${cyan}   NAME:    ${variable} ${clr}")
		dk_echo("${cyan}   TYPE:    ${variableType} ${clr}")
		dk_echo("${cyan}   LENGTH:  ${variableLength} ${clr}")
		dk_echo("${cyan}   VALUE:   ${${variable}} ${clr}")
		dk_echo("${cyan}############################################################################################${clr}\n")
	endif()
<<<<<<< HEAD
	#dk_wait()
=======
	#dk_timeout()
>>>>>>> Development
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()
