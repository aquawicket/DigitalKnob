#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##############################################################################
# dk_watchCallback(variable, access, value, current_list_file, stack)
# 
#	Description:  https://cmake.org/cmake/help/latest/command/variable_watch.html
#
#	@variable	- Name of the variable being accessed.
#	@access 	- One of READ_ACCESS, UNKNOWN_READ_ACCESS, MODIFIED_ACCESS, UNKNOWN_MODIFIED_ACCESS, or REMOVED_ACCESS.
#	@value 		- The value of the variable. On a modification, this is the new (modified) value of the variable. On removal, the value is empty.
#   @1st 		- Full path to the file doing the access.
#	@stack 		- List of absolute paths of all files currently on the stack of file inclusion, with the bottom-most file first.
#
macro(dk_watchCallback variable access value current_list_file stack)
	#dk_debugFunc("\${ARGV}")
	if("${access}" STREQUAL "MODIFIED_ACCESS")
	#	dk_echo("${cyan}################################ VARIABLE WATCH: ${variable} ############################################${clr}")
		dk_echo("")
		dk_echo("---------------------------------------")
		dk_echo("${cyan}  variable = ${variable} ${clr}")
		dk_echo("${cyan}  access   = ${access} ${clr}")
	#	dk_echo("${cyan}  value    = ${value} ${clr}")
	#	dk_echo("${cyan}  file     = ${current_list_file} ${clr}")
		dk_echo("${cyan}  stack    = ${stack} ${clr}")
		dk_echo("${cyan}  > ${CMAKE_CURRENT_FUNCTION_LIST_FILE}:${CMAKE_CURRENT_FUNCTION_LIST_LINE}   ${CMAKE_CURRENT_FUNCTION}()")
	#	dk_echo("${cyan}#########################################################################################################${clr}")
	endif()
endmacro()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()