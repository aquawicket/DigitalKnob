#!/usr/bin/cmake -P
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
	dk_debugFunc("\${ARGV}")
	if(${ARGC} EQUAL 0)
		message("") # newline
		return()
	endif()
	if(NOT ${ARGC} EQUAL 1)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
#	if(NOT echo_fileline)
#		__FILE__(_FILE_ 1)
#		__LINE__(_LINE_ 1)
#		dk_basename("${_FILE_}" _FILE_)
#		set(echo_fileline "${_FILE_}:${_LINE_}   " CACHE INTERNAL "")
#	endif()
	set(msg ${ARGV})
#	dk_unset(echo_fileline)
	message("${echo_fileline}${msg}")
#	dk_unset(echo_fileline)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	message("This is a normal message commmand")
	dk_echo()
	dk_echo("")
	dk_echo("This is a dk_echo line")
	dk_echo("${red}This is ${white}dk_echo ${blue}with color ${clr}")
endfunction()