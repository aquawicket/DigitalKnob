#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_getParameterValue(name)
#
#	TODO: change to dk_getParameterValue(name output ${ARGV}) so we can choose the variable to recieve the option in
#
#	EXAMPLE: dk_getParameterValue(MY_ARG ${ARGV})
#
macro(dk_getParameterValue)
	dk_debugFunc()
	
	###### ARGV - dk_getParameter args ######
	#message("ARGV  = ${ARGV}")
	
	###### ARGN - dk_getParameter extra args ######
	#message("ARGN  = ${ARGN}")
	
	###### PARGV - Parent Function args ######
	unset(PARGV)
	foreach(arg IN LISTS ARGV)
		list(APPEND PARGV ${arg})
	endforeach()
	#message("PARGV = ${PARGV}")

	#########################################
	
	set(dk_getParameterValue_NAME ${ARGV0})
	cmake_parse_arguments(ARG "" "${dk_getParameterValue_NAME}" "" ${PARGV})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})
	
	if(ARG_${dk_getParameterValue_NAME})
		set(${dk_getParameterValue_NAME} ${ARG_${dk_getParameterValue_NAME}})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameterValue_NAME} set to ${ARG_${dk_getParameterValue_NAME}}")
		
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${dk_getParameterValue_NAME})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameterValue_NAME} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGV ${ARG_${dk_getParameterValue_NAME}})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${ARG_${dk_getParameterValue_NAME}} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGN ${dk_getParameterValue_NAME})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameterValue_NAME} REMOVED from ARGN")
			
			list(REMOVE_ITEM ARGN ${ARG_${dk_getParameterValue_NAME}})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${ARG_${dk_getParameterValue_NAME}} REMOVED from ARGN")
		endif()
	else()
		unset(${dk_getParameterValue_NAME})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameterValue_NAME} unset")
	endif()
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_dk_getParameter(abc OPTION1 "value1" OPTION2 "value2" OPTION4 "value4")
endfunction()

function(TEST_dk_getParameter input1)
	dk_debugFunc(1 99)
	
	message("TEST_dk_getParameter(${ARGV})")
	set(OPTION1 "UNDEFINED")
	set(OPTION2 "UNDEFINED")
	set(OPTION3 "UNDEFINED")
	set(OPTION4 "UNDEFINED")
	
	dk_getParameterValue(OPTION1)
	dk_getParameterValue(OPTION2 REMOVE)
	dk_getParameterValue(OPTION3)
	dk_getParameterValue(OPTION4)
	
	message("")
	message("######## AFTER ##################")
	message("ARGV = ${ARGV}")
	message("ARGN = ${ARGN}")
	message("OPTION1 = ${OPTION1}")
	message("OPTION2 = ${OPTION2}")
	message("OPTION3 = ${OPTION3}")
	message("OPTION4 = ${OPTION4}")
endfunction()