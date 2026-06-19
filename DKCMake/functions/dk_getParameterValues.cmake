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

# FIXME: This is not fully functional. It take code from dk_getParameterValue() 
# but has not yet ben set up to recieve multiple variables, or been tested
#########################################################################
# dk_getParameterValues(name)
#
#	TODO: change to dk_getParameterValues(name output ${ARGV}) so we can choose the variable to recieve the option in
#
#	EXAMPLE: dk_getParameterValues(MY_ARG ${ARGV})
#
macro(dk_getParameterValues)
	dk_debugFunc()
	
	###### ARGV - dk_getParameter args ######
	#dk_debug("ARGV  = ${ARGV}")
	
	###### ARGN - dk_getParameter extra args ######
	#dk_debug("ARGN  = ${ARGN}")
	
	###### PARGV - Parent Function args ######
	unset(PARGV)
	foreach(arg IN LISTS ARGV)
		list(APPEND PARGV ${arg})
	endforeach()
	#dk_debug("PARGV = ${PARGV}")

	#########################################
	
	set(dk_getParameterValues_NAME ${ARGV0})
	cmake_parse_arguments(ARG "" "${dk_getParameterValues_NAME}" "" ${PARGV})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})
	
	if(ARG_${dk_getParameterValues_NAME})
		set(${dk_getParameterValues_NAME} ${ARG_${dk_getParameterValues_NAME}})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameterValues_NAME} set to ${ARG_${dk_getParameterValues_NAME}}")
		
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${dk_getParameterValues_NAME})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameterValues_NAME} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGV ${ARG_${dk_getParameterValues_NAME}})	# remove arg from the functions ARGV list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${ARG_${dk_getParameterValues_NAME}} REMOVED from ARGV")
			
			list(REMOVE_ITEM ARGN ${dk_getParameterValues_NAME})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameterValues_NAME} REMOVED from ARGN")
			
			list(REMOVE_ITEM ARGN ${ARG_${dk_getParameterValues_NAME}})	# remove arg from the functions ARGN list
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${ARG_${dk_getParameterValues_NAME}} REMOVED from ARGN")
		endif()
	else()
		unset(${dk_getParameterValues_NAME})
		#dk_notice("${CMAKE_CURRENT_FUNCTION}(): ${dk_getParameterValues_NAME} unset")
	endif()
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_dk_getParameter(abc OPTION1 "value1" OPTION2 "value2" OPTION4 "value4")
endfunction()

function(TEST_dk_getParameter input1)
	dk_debugFunc(1 99)
	
	dk_debug("TEST_dk_getParameter(${ARGV})")
	set(OPTION1 "UNDEFINED")
	set(OPTION2 "UNDEFINED")
	set(OPTION3 "UNDEFINED")
	set(OPTION4 "UNDEFINED")
	
	dk_getParameterValues(OPTION1)
	dk_getParameterValues(OPTION2 REMOVE)
	dk_getParameterValues(OPTION3)
	dk_getParameterValues(OPTION4)
	
	dk_debug("")
	dk_debug("######## AFTER ##################")
	dk_debug("ARGV = ${ARGV}")
	dk_debug("ARGN = ${ARGN}")
	dk_debug("OPTION1 = ${OPTION1}")
	dk_debug("OPTION2 = ${OPTION2}")
	dk_debug("OPTION3 = ${OPTION3}")
	dk_debug("OPTION4 = ${OPTION4}")
endfunction()