#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_getOption(name ${ARGV}) REMOVE
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
function(dk_getOption name)
	dk_debugFunc()
	
	cmake_parse_arguments(ARG ${name} "" "" ${ARGN})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})

	if(ARG_${name})
		set(${name} ${name} PARENT_SCOPE)
		
		#dk_debug("${CMAKE_CURRENT_FUNCTION}(): ${name}=ON")
		if(ARG_REMOVE)
			set(ARG_LIST ${ARGN})
			list(REMOVE_ITEM ARG_LIST ${name})	# remove item from the functions ARGV list
			list(REMOVE_ITEM ARG_LIST REMOVE)	# remove item from the functions ARGV list
			set(ARGV ${ARG_LIST} PARENT_SCOPE)
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(${name}) REMOVED")
			#dk_notice("${name} REMOVED")
		endif()
	else()
		dk_unset(${name} PARENT_SCOPE)
		#dk_debug("${CMAKE_CURRENT_FUNCTION}(): ${name}=OFF")
	endif()
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	TEST_dk_getOption(OPTION1 OPTION2 OPTION3)
endfunction()


function(TEST_dk_getOption)
	dk_debugFunc()
	
	dk_getOption(OPTION1 ${ARGV})
	dk_getOption(OPTION2 ${ARGV} REMOVE)
	#dk_getOption(OPTION3 ${ARGV})
	
	message("ARGV = ${ARGV}")
	message("OPTION1 = ${OPTION1}")
	message("OPTION2 = ${OPTION2}")
	message("OPTION3 = ${OPTION3}")
endfunction()