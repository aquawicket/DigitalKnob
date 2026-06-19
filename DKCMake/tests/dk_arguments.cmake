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
# dk_arguments()
#
#
macro(dk_arguments)
	dk_debugFunc()
	
	######### CMAKE_ variables #########
	dk_echo("")
	dk_echo("CMAKE_CURRENT_FUNCTION             = ${CMAKE_CURRENT_FUNCTION}")
	dk_echo("CMAKE_CURRENT_FUNCTION_LIST_DIR    = ${CMAKE_CURRENT_FUNCTION_LIST_DIR}")
	dk_echo("CMAKE_CURRENT_FUNCTION_LIST_FILE   = ${CMAKE_CURRENT_FUNCTION_LIST_FILE}")
	dk_echo("CMAKE_CURRENT_FUNCTION_LIST_LINE   = ${CMAKE_CURRENT_FUNCTION_LIST_LINE}")
	dk_echo("CMAKE_CURRENT_LIST_DIR             = ${CMAKE_CURRENT_LIST_DIR}")
	dk_echo("CMAKE_CURRENT_LIST_FILE            = ${CMAKE_CURRENT_LIST_FILE}")
	dk_echo("CMAKE_CURRENT_LIST_LINE            = ${CMAKE_CURRENT_LIST_LINE}")
	#####################################
	
	dk_CMAKE_ARGV()
	
	dk_echo("")
	dk_echo("CMAKE_ARGV                         = ${CMAKE_ARGV}")
	dk_echo("CMAKE_ARGC                         = ${CMAKE_ARGC}")
	math(EXPR CMAKE_ARGC_END "${CMAKE_ARGC}-1")
	foreach(n RANGE ${CMAKE_ARGC_END})
		dk_echo("CMAKE_ARGV${n}                 = ${CMAKE_ARGV${n}}")
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
	
	dk_echo("")
	dk_echo("argv                               = ${argv}")
	dk_echo("argc                               = ${argc}")
	math(EXPR argc_end "${argc}-1")
	foreach(n RANGE ${argc_end})
		dk_echo("argv${n}                              = ${argv${n}}")
	endforeach()
	#####################################################

	###### argn/argnc - current macro extra args/count ######
	set(argnc 0)
	set(argn "${ARGN}")
	foreach(arg IN LISTS argn)
		set(argn${argnc} ${arg})
		math(EXPR argnc "${argnc}+1")		
	endforeach()
	
	dk_echo("")
	dk_echo("argn                               = ${argn}")
	dk_echo("argnc                              = ${argnc}")
	math(EXPR argnc_end "${argnc}-1")
	foreach(n RANGE ${argnc_end})
		dk_echo("argn${n}                              = ${argn${n}}")
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
	
	dk_echo("")
	dk_echo("PARGV                              = ${PARGV}")
	dk_echo("PARGC                              = ${PARGC}")
	math(EXPR PARGC_END "${PARGC}-1")
	foreach(n RANGE ${PARGC_END})
		dk_echo("PARGV${n}                             = ${PARGV${n}}")
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

	dk_echo("")
	dk_echo("PARGN                              = ${PARGN}")
	dk_echo("PARGNC                             = ${PARGNC}")
	math(EXPR PARGNC_END "${PARGNC}-1")
	foreach(n RANGE ${PARGNC_END})
		dk_echo("PARGN${n}                             = ${PARGN${n}}")
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
	
	dk_echo("TEST_function(${ARGV})")
	dk_arguments(arg1 arg2)
	dk_echo("")
endfunction()

macro(TEST_macro param1)
	#dk_debugFunc()
	
	dk_echo("TEST_macro(${ARGV})")
	dk_arguments(arg1 arg2 arg3)
	dk_echo("")
endmacro()

DKTEST()