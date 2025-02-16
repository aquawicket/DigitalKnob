#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

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
macro(dk_getOption)
	dk_debugFunc()
	
	###### ARGV - dk_getOption args ######
	#message("ARGV  = ${ARGV}")
	
	###### ARGN - dk_getOption extra args ######
	#message("ARGN  = ${ARGN}")
	
	###### PARGV - Parent Function args ######
	unset(PARGV)
	foreach(arg IN LISTS ARGV)
		list(APPEND PARGV ${arg})
	endforeach()
	#message("PARGV = ${PARGV}")

	#########################################
	
	
	set(dk_getOption_NAME ${ARGV0})
	cmake_parse_arguments(ARG ${dk_getOption_NAME} "" "" ${PARGV})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGV})

	if(ARG_${dk_getOption_NAME})
		set(${dk_getOption_NAME} 1)
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getOption_NAME} set to 1")
		
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${dk_getOption_NAME})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getOption_NAME} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGN ${dk_getOption_NAME})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getOption_NAME} REMOVED from ARGN")
		endif()
	else()
		unset(${dk_getOption_NAME})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getOption_NAME} unset")
	endif()
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_dk_getOption(abc OPTION1 OPTION2 123 OPTION4)
endfunction()

function(TEST_dk_getOption input1)
	dk_debugFunc(1 99)
	
	message("TEST_dk_getOption(${ARGV})")
	set(OPTION1 "UNDEFINED")
	set(OPTION2 "UNDEFINED")
	set(OPTION3 "UNDEFINED")
	set(OPTION4 "UNDEFINED")
	
	dk_getOption(OPTION1)
	dk_getOption(OPTION2 REMOVE)
	dk_getOption(OPTION3)
	dk_getOption(OPTION4)
	
	message("")
	message("######## AFTER ##################")
	message("ARGV = ${ARGV}")
	message("ARGN = ${ARGN}")
	message("OPTION1 = ${OPTION1}")
	message("OPTION2 = ${OPTION2}")
	message("OPTION3 = ${OPTION3}")
	message("OPTION4 = ${OPTION4}")
endfunction()