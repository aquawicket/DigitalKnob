#!/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_echo(msg)
#
#	Print a message to the console
#
#	@msg	- The message to print
#
function(dk_echo)
	dk_debugFunc(${ARGV})
	if(${ARGC} EQUAL 0)
		message("") # newline
		return()
	endif()
	if(NOT ${ARGC} EQUAL 1)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	
	set(msg ${ARGV})
	message("${msg}")
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	message("This is a normal message commmand")
	dk_echo()
	dk_echo("")
	dk_echo("This is a dk_echo line")
	dk_echo("${red}This is ${white}dk_echo ${blue}with color ${clr}")
endfunction()