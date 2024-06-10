include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

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
	dk_debugFunc(${ARGV})
	
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
			dk_notice("${name} REMOVED")
		endif()
	else()
		unset(${name} PARENT_SCOPE)
		#dk_debug("${CMAKE_CURRENT_FUNCTION}(): ${name}=OFF")
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)