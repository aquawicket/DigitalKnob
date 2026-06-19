#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_BREAKPOINT(variable)
# 
#	Print the contents of a variable to the screen
#
#	@variable	- The variable to print to the screen. Without variable brackets ${ }'
#
macro(dk_BREAKPOINT)
	dk_debugFunc(0 99)
	
#	if(NOT DEFINED ${ARGV})
#		dk_fatal("ARGV not defined. The syntax may be incorrect if using brackets - > \$ { variable } ")
#		dk_info("${clr}${green} dk_BREAKPOINT(variable): <- CORRECT SYNTAX")
#	endif()	
	
	if(CMAKE_CURRENT_FUNCTION_LIST_FILE)
		dk_basename(${CMAKE_CURRENT_FUNCTION_LIST_FILE} FILENAME)
	endif()
	
	message("\n${cyan}########################### BREAKPOINT ################################")	
	
	message("          CMAKE_CURRENT_FUNCTION: ${CMAKE_CURRENT_FUNCTION}")
	message("CMAKE_CURRENT_FUNCTION_LIST_FILE: ${CMAKE_CURRENT_FUNCTION_LIST_FILE}")
	message("CMAKE_CURRENT_FUNCTION_LIST_LINE: ${CMAKE_CURRENT_FUNCTION_LIST_LINE}")
	#message("                CALLING_FUNCTION: ${CALLING_FUNCTION}")  # TODO
	message("         CMAKE_CURRENT_LIST_FILE: ${CMAKE_CURRENT_LIST_FILE}")
	message("         CMAKE_CURRENT_LIST_LINE: ${CMAKE_CURRENT_LIST_LINE}")
	set(argc ${ARGC})
	message("                            ARGC: '${argc}'")
	set(argv ${ARGV})
	message("                            ARGV: '${argv}'")
	set(n 0)
	foreach(ARG IN LISTS argv)
	dk_echo("                           ARGV${n}: '${ARG}'")
		math(EXPR n "${n}+1")
	endforeach()
	get_cmake_property(CMAKE_ROLE CMAKE_ROLE)
	message("CMAKE_ROLE = ${CMAKE_ROLE}")
	get_cmake_property(LISTFILE_STACK LISTFILE_STACK)
	message("LISTFILE_STACK = ${LISTFILE_STACK}")
	dk_echo("##########################################################################${clr}\n")
	
	
#	list(LENGTH ARGV ARGV_length)
#	if(${ARGV_length} GREATER 1)
#		set(ARGV_type "list")
#	elseif(ARGV MATCHES "^[0-9]+$")
#		set(ARGV_type "number")
#	else()
#		set(ARGV_type "string")
#	endif()
#	dk_echo("${cyan}   NAME:    ${ARGV} ${clr}")
#	dk_echo("${cyan}   TYPE:    ${ARGV_type} ${clr}")
#	dk_echo("${cyan}   LENGTH:  ${ARGV_length} ${clr}")
#	dk_echo("${cyan}   VALUE:   ${${ARGV}} ${clr}")
	
	
	
	
	dk_pause()
endmacro()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	set(myVar "a b c")
	dk_BREAKPOINT(myVar)
endfunction()
