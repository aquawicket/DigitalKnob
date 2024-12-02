#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_getOption(name) REMOVE
#
#	Check if the parameter exists in the calling function by <name>
#	If the named parameter was defined, set it's value to it's name.
#	This allows it to be optionally sent by value to functions
#
#	@name - the name of the variable to check foreach
#	@${ARGV} - The parameter list of the function
#	@REMOVE (optional) - Remove the parameter from ARGV after setting the state   
#
#	EXAMPLE: dk_getOption(MY_ARG ${ARGV})
#
macro(dk_getOption2)
	dk_debugFunc()
	
	###### ARGV - dk_getOption2 args ######
	message("ARGV  = ${ARGV}")
	
	###### ARGN - dk_getOption2 extra args ######
	message("ARGN  = ${ARGN}")
	
	###### PARGV - Parent Function args ######
	unset(PARGV)
	foreach(arg IN LISTS ARGV)
		list(APPEND PARGV ${arg})
	endforeach()
	message("PARGV = ${PARGV}")
	
	###### PARGN - Parent Function args ######
	unset(PARGN)
	foreach(arg IN LISTS ARGN)
		list(APPEND PARGN ${arg})
	endforeach()
	message("PARGN = ${PARGN}")

#	unset(_DKARGV_COUNT_)
#	list(LENGTH _DKARGV_ _DKARGV_COUNT_)
	
	set(NAME ${ARGV0})
	cmake_parse_arguments(ARG ${NAME} "" "" ${PARGV})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGV})

	if(ARG_${NAME})
		dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${NAME} set to 1")
		set(${NAME} 1)
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${NAME})	# remove arg from the functions ARGV list
			dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${NAME} REMOVED from ARGV")
			list(REMOVE_ITEM ARGN ${NAME})	# remove arg from the functions ARGN list
			dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${NAME} REMOVED from ARGN")
		endif()
	else()
		dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${NAME} unset")
		unset(${NAME})
	endif()
	
	message("")
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_dk_getOption(abc OPTION1 OPTION2 123 OPTION4)
endfunction()

function(TEST_dk_getOption input1)
	dk_debugFunc()
	
	message("TEST_dk_getOption(${ARGV})")
	set(OPTION1 "UNDEFINED")
	set(OPTION2 "UNDEFINED")
	set(OPTION3 "UNDEFINED")
	set(OPTION4 "UNDEFINED")
	
	dk_getOption2(OPTION1)
	dk_getOption2(OPTION2 REMOVE)
	dk_getOption2(OPTION3)
	dk_getOption2(OPTION4)
	
	message("")
	message("######## AFTER ##################")
	message("ARGV = ${ARGV}")
	message("ARGN = ${ARGN}")
	message("OPTION1 = ${OPTION1}")
	message("OPTION2 = ${OPTION2}")
	message("OPTION3 = ${OPTION3}")
	message("OPTION4 = ${OPTION4}")
endfunction()