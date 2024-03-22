include_guard()

###############################################################################
# dk_get_option(name ${ARGV}) REMOVE
#
#	Check if the parameter exists in the calling function by <name>
#	If the named parameter was defined, set it's value to it's name.
#	This allows it to be optionally sent by value to functions
#
#	@name - the name of the variable to check foreach
#	@${ARGV} - The parameter list of the function
#	@REMOVE (optional) - Remove the parameter from ARGV after setting the state   
#
#	EXAMPLE: dk_get_option(MY_ARG ${ARGV})
#
macro(dk_get_option name)
	#message("dk_get_option(${name})")
	#message("${CMAKE_CURRENT_FUNCTION}(${ARGN})")
	cmake_parse_arguments(ARG ${name} "" "" ${ARGN})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})
	if(ARG_${name})
		set(${name} ${name})
		#message(STATUS "${CMAKE_CURRENT_FUNCTION}(): ${name}=ON")
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${name})	# remove item from the functions ARGV list
			dk_notice("${CMAKE_CURRENT_FUNCTION}(${name}) REMOVED")
		endif()
	else()
		unset(${name})
		#message(STATUS "${CMAKE_CURRENT_FUNCTION}(): ${name}=OFF")
	endif()
endmacro()