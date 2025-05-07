#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_getParameter(name) REMOVE
#
#	Check if the parameter exists in the calling function by <name>
#	If the named parameter was defined, set it's value to it's name.
#	This allows it to be optionally sent by value to functions
#
#	@name - the name of the variable to check foreach
#	@${ARGV} - The parameter list of the function
#	@REMOVE (optional) - Remove the parameter from ARGV after setting the state   
#
#	EXAMPLE: dk_getParameter(MY_ARG ${ARGV})
#
macro(dk_getParameter)
	dk_debugFunc()
	
	###### ARGV - dk_getParameter args ######
	#message("dk_getParameter(ARGC = ${ARGC})")
	#message("dk_getParameter(ARGV = ${ARGV})")
	
	###### ARGN - dk_getParameter extra args ######
	#message("dk_getParameter(ARGN = ${ARGN})")
	
	###### PARGV - Parent Function args ######
	set(PARGC 0)
	unset(PARGV)
	foreach(arg IN LISTS ARGV)
		math(EXPR PARGC "${PARGC} + 1" OUTPUT_FORMAT DECIMAL)
		list(APPEND PARGV ${arg})
	endforeach()
	#message("PARGC = ${PARGC}")
	#message("PARGV = ${PARGV}")

	#########################################
	
	set(dk_getParameter_NAME ${ARGV0})
	cmake_parse_arguments(ARG ${dk_getParameter_NAME} "" "" ${PARGV})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGV})

	if(ARG_${dk_getParameter_NAME})
		set(${dk_getParameter_NAME} "${dk_getParameter_NAME}")
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameter_NAME} set to "${dk_getParameter_NAME}")
		
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${dk_getParameter_NAME})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameter_NAME} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGN ${dk_getParameter_NAME})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameter_NAME} REMOVED from ARGN")
		endif()
	else()
		unset(${dk_getParameter_NAME})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameter_NAME} unset")
	endif()
	
	set(PARGC 0)
	foreach(arg IN LISTS ARGV)
		math(EXPR PARGC "${PARGC} + 1" OUTPUT_FORMAT DECIMAL)
	endforeach()
	set(ARGC ${PARGC})
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_dk_getParameter(abc OPTION1 OPTION2 123 OPTION4)
endfunction()

function(TEST_dk_getParameter input1)
	dk_debugFunc(1 99)
	
	message("TEST_dk_getParameter(${ARGV})")
	set(OPTION1 "UNDEFINED")
	set(OPTION2 "UNDEFINED")
	set(OPTION3 "UNDEFINED")
	set(OPTION4 "UNDEFINED")
	
	dk_getParameter(OPTION1)
	dk_getParameter(OPTION2 REMOVE)
	dk_getParameter(OPTION3)
	dk_getParameter(OPTION4)
	
	message("")
	message("######## AFTER ##################")
	message("ARGV = ${ARGV}")
	message("ARGN = ${ARGN}")
	message("OPTION1 = ${OPTION1}")
	message("OPTION2 = ${OPTION2}")
	message("OPTION3 = ${OPTION3}")
	message("OPTION4 = ${OPTION4}")
endfunction()