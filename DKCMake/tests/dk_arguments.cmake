#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_arguments()
#
#
macro(dk_arguments param1)
	dk_debugFunc()
	
	###### CMAKE_ARGV - cmake args ######
	unset(CMAKE_ARGV)
	math(EXPR CMAKE_LASTC "${CMAKE_ARGC}-1")
	foreach(index RANGE ${CMAKE_LASTC})
		list(APPEND CMAKE_ARGV ${CMAKE_ARGV${index}})
	endforeach()
	
	###### ARGNC - cmake args ######
	set(ARGNC 0)
	set(_ARGN_ ${ARGN})
	foreach(arg IN LISTS _ARGN_)
		math(EXPR ARGNC "${ARGNC}+1")
	endforeach()
	
	###### PARGV - Parent Function args ######
	unset(PARGV)
	set(PARGC 0)
	foreach(arg IN LISTS ARGV)
		list(APPEND PARGV ${arg})
		math(EXPR PARGC "${PARGC}+1")
	endforeach()
	
	###### PARGN - Parent Function args ######
	unset(PARGN)
	set(PARGNC 0)
	foreach(arg IN LISTS ARGN)
		list(APPEND PARGN ${arg})
		math(EXPR PARGNC "${PARGNC}+1")
	endforeach()
	
	###### ARGV - dk_arguments args ######
	message("CMAKE_ARGV                         = ${CMAKE_ARGV}")
	message("CMAKE_ARGC                         = ${CMAKE_ARGC}")
	message("CMAKE_CURRENT_FUNCTION             = ${CMAKE_CURRENT_FUNCTION}")
	message("CMAKE_CURRENT_FUNCTION_LIST_DIR    = ${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
	message("CMAKE_CURRENT_FUNCTION_LIST_FILE   = ${CMAKE_CURRENT_FUNCTION_LIST_FILE}")
	message("CMAKE_CURRENT_FUNCTION_LIST_LINE   = ${CMAKE_CURRENT_FUNCTION_LIST_LINE}")
	message("CMAKE_CURRENT_LIST_DIR             = ${CMAKE_CURRENT_LIST_DIR}")
	message("CMAKE_CURRENT_LIST_FILE            = ${CMAKE_CURRENT_LIST_FILE}")
	message("CMAKE_CURRENT_LIST_LINE            = ${CMAKE_CURRENT_LIST_LINE}")
	message("ARGV                               = ${ARGV}")
	message("ARGC                               = ${ARGC}")
	message("ARGN                               = ${ARGN}")
	message("ARGNC                              = ${ARGNC}")
	message("PARGV                              = ${PARGV}")
	message("PARGC                              = ${PARGC}")
	message("PARGN                              = ${PARGN}")
	message("PARGNC                             = ${PARGNC}")
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_function(abc OPTION1 "value1" 123 OPTION2 "value2" OPTION4 "value4")
	TEST_macro(abc OPTION1 "value1" 123 OPTION2 "value2" OPTION4 "value4")
endfunction()

function(TEST_function param1)
	#dk_debugFunc()
	
	message("TEST_function(${ARGV})")
	dk_arguments(arg1 arg2)
	message("")
endfunction()

macro(TEST_macro param1)
	#dk_debugFunc()
	
	message("TEST_macro(${ARGV})")
	dk_arguments(arg1 arg2 arg3)
	message("")
endmacro()

DKTEST()