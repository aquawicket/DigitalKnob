#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_arguments()
#
#
macro(dk_arguments)
	dk_debugFunc()
	
	######### CMAKE_ variables #########
	message("")
	message("CMAKE_CURRENT_FUNCTION             = ${CMAKE_CURRENT_FUNCTION}")
	message("CMAKE_CURRENT_FUNCTION_LIST_DIR    = ${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
	message("CMAKE_CURRENT_FUNCTION_LIST_FILE   = ${CMAKE_CURRENT_FUNCTION_LIST_FILE}")
	message("CMAKE_CURRENT_FUNCTION_LIST_LINE   = ${CMAKE_CURRENT_FUNCTION_LIST_LINE}")
	message("CMAKE_CURRENT_LIST_DIR             = ${CMAKE_CURRENT_LIST_DIR}")
	message("CMAKE_CURRENT_LIST_FILE            = ${CMAKE_CURRENT_LIST_FILE}")
	message("CMAKE_CURRENT_LIST_LINE            = ${CMAKE_CURRENT_LIST_LINE}")
	#####################################
	
	###### CMAKE_ARGV - cmake command line args ######
	unset(CMAKE_ARGV)
	math(EXPR CMAKE_LASTC "${CMAKE_ARGC}-1")
	foreach(index RANGE ${CMAKE_LASTC})
		list(APPEND CMAKE_ARGV ${CMAKE_ARGV${index}})
	endforeach()
	
	message("")
	message("CMAKE_ARGV                         = ${CMAKE_ARGV}")
	message("CMAKE_ARGC                         = ${CMAKE_ARGC}")
	math(EXPR CMAKE_ARGC_END "${CMAKE_ARGC}-1")
	foreach(n RANGE ${CMAKE_ARGC_END})
		message("CMAKE_ARGV${n}                        = ${CMAKE_ARGV${n}}")
	endforeach()
	#####################################
	
	# DO NOT USE ARGV, ARGC, ARGN, ARGV{n} OR ARGN{n}
	
	
	###### argv/argc - current macro args/count ######
	set(argc 0)
	set(argv "${ARGV}")
	foreach(arg IN LISTS argv)
		set(argv${argc} ${arg})
		math(EXPR argc "${argc}+1")		
	endforeach()
	
	message("")
	message("argv                               = ${argv}")
	message("argc                               = ${argc}")
	math(EXPR argc_end "${argc}-1")
	foreach(n RANGE ${argc_end})
		message("argv${n}                              = ${argv${n}}")
	endforeach()
	#####################################################

	###### argn/argnc - current macro extra args/count ######
	set(argnc 0)
	set(argn "${ARGN}")
	foreach(arg IN LISTS argn)
		set(argn${argnc} ${arg})
		math(EXPR argnc "${argnc}+1")		
	endforeach()
	
	message("")
	message("argn                               = ${argn}")
	message("argnc                              = ${argnc}")
	math(EXPR argnc_end "${argnc}-1")
	foreach(n RANGE ${argnc_end})
		message("argn${n}                              = ${argn${n}}")
	endforeach()
	#############################################################
	
	
	###### PARGV - Parent Function args ######
	unset(PARGV)
	set(PARGC 0)
	foreach(arg IN LISTS ARGV)
		set(PARGV${PARGC} ${arg})
		list(APPEND PARGV ${arg})
		math(EXPR PARGC "${PARGC}+1")
	endforeach()
	
	message("")
	message("PARGV                              = ${PARGV}")
	message("PARGC                              = ${PARGC}")
	math(EXPR PARGC_END "${PARGC}-1")
	foreach(n RANGE ${PARGC_END})
		message("PARGV${n}                             = ${PARGV${n}}")
	endforeach()
	###########################################
	
	###### PARGN - Parent Function args ######
	unset(PARGN)
	set(PARGNC 0)
	foreach(arg IN LISTS ARGN)
		set(PARGN${PARGNC} ${arg})
		list(APPEND PARGN ${arg})
		math(EXPR PARGNC "${PARGNC}+1")
	endforeach()

	message("")
	message("PARGN                              = ${PARGN}")
	message("PARGNC                             = ${PARGNC}")
	math(EXPR PARGNC_END "${PARGNC}-1")
	foreach(n RANGE ${PARGNC_END})
		message("PARGN${n}                             = ${PARGN${n}}")
	endforeach()
	##########################################
	
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_function(abc OPTION1 "value1" 123 OPTION2 "value2" OPTION4 "value4")	
	#TEST_macro(abc OPTION1 "value1" 123 OPTION2 "value2" OPTION4 "value4")
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