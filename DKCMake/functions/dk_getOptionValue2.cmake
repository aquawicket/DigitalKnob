#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_getOptionValue2(name)
#
#	TODO: change to dk_getOptionValue(name output ${ARGV}) so we can choose the variable to recieve the option in
#
#	EXAMPLE: dk_getOptionValue(MY_ARG ${ARGV})
#
macro(dk_getOptionValue2)
	dk_debugFunc()
	
	###### ARGV - dk_getOption2 args ######
	#message("ARGV  = ${ARGV}")
	
	###### ARGN - dk_getOption2 extra args ######
	#message("ARGN  = ${ARGN}")
	
	###### PARGV - Parent Function args ######
	unset(PARGV)
	foreach(arg IN LISTS ARGV)
		list(APPEND PARGV ${arg})
	endforeach()
	#message("PARGV = ${PARGV}")
	
	###### PARGN - Parent Function args ######
	unset(PARGN)
	foreach(arg IN LISTS ARGN)
		list(APPEND PARGN ${arg})
	endforeach()
	#message("PARGN = ${PARGN}")

	#########################################
	
	set(NAME ${ARGV0})
	cmake_parse_arguments(ARG "" "${NAME}" "" ${PARGV})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})
	
	if(ARG_${NAME})
		set(${NAME} ${ARG_${NAME}})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${NAME} set to ${ARG_${NAME}}")
		
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${NAME})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${NAME} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGV ${ARG_${NAME}})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${ARG_${NAME}} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGN ${NAME})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${NAME} REMOVED from ARGN")
			
			list(REMOVE_ITEM ARGN ${ARG_${NAME}})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${ARG_${NAME}} REMOVED from ARGN")
		endif()
	else()
		unset(${NAME})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${NAME} unset")
	endif()
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_dk_getOption(abc OPTION1 "value1" OPTION2 "value2" OPTION4 "value4")
endfunction()

function(TEST_dk_getOption input1)
	dk_debugFunc(1 99)
	
	message("TEST_dk_getOption(${ARGV})")
	set(OPTION1 "UNDEFINED")
	set(OPTION2 "UNDEFINED")
	set(OPTION3 "UNDEFINED")
	set(OPTION4 "UNDEFINED")
	
	dk_getOptionValue2(OPTION1)
	dk_getOptionValue2(OPTION2 REMOVE)
	dk_getOptionValue2(OPTION3)
	dk_getOptionValue2(OPTION4)
	
	message("")
	message("######## AFTER ##################")
	message("ARGV = ${ARGV}")
	message("ARGN = ${ARGN}")
	message("OPTION1 = ${OPTION1}")
	message("OPTION2 = ${OPTION2}")
	message("OPTION3 = ${OPTION3}")
	message("OPTION4 = ${OPTION4}")
endfunction()