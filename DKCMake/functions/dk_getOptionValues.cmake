#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

# FIXME: This is not fully functional. It take code from dk_getOptionValue() 
# but has not yet ben set up to recieve multiple variables, or been tested
###############################################################################
# dk_getOptionValues(name)
#
#	TODO: change to dk_getOptionValues(name output ${ARGV}) so we can choose the variable to recieve the option in
#
#	EXAMPLE: dk_getOptionValues(MY_ARG ${ARGV})
#
macro(dk_getOptionValues)
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
	
	set(dk_getOptionValues_NAME ${ARGV0})
	cmake_parse_arguments(ARG "" "${dk_getOptionValues_NAME}" "" ${PARGV})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})
	
	if(ARG_${dk_getOptionValues_NAME})
		set(${dk_getOptionValues_NAME} ${ARG_${dk_getOptionValues_NAME}})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getOptionValues_NAME} set to ${ARG_${dk_getOptionValues_NAME}}")
		
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${dk_getOptionValues_NAME})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getOptionValues_NAME} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGV ${ARG_${dk_getOptionValues_NAME}})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${ARG_${dk_getOptionValues_NAME}} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGN ${dk_getOptionValues_NAME})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getOptionValues_NAME} REMOVED from ARGN")
			
			list(REMOVE_ITEM ARGN ${ARG_${dk_getOptionValues_NAME}})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${ARG_${dk_getOptionValues_NAME}} REMOVED from ARGN")
		endif()
	else()
		unset(${dk_getOptionValues_NAME})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getOptionValues_NAME} unset")
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
	
	dk_getOptionValues(OPTION1)
	dk_getOptionValues(OPTION2 REMOVE)
	dk_getOptionValues(OPTION3)
	dk_getOptionValues(OPTION4)
	
	message("")
	message("######## AFTER ##################")
	message("ARGV = ${ARGV}")
	message("ARGN = ${ARGN}")
	message("OPTION1 = ${OPTION1}")
	message("OPTION2 = ${OPTION2}")
	message("OPTION3 = ${OPTION3}")
	message("OPTION4 = ${OPTION4}")
endfunction()