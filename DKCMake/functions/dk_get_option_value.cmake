include_guard()

###############################################################################
# dk_get_option_value(name ${ARGV}) 
#
#	TODO: change to dk_get_option_value(name output ${ARGV}) so we change choose the variable to recieve the option in
#
#	EXAMPLE: dk_get_option_value(MY_ARG ${ARGV})
#
macro(dk_get_option_value name)
	cmake_parse_arguments(ARG "" "${name}" "" ${ARGN})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})
	#dk_print_prefix_vars("ARG_")
	if(ARG_${name})
		set(${name} ${ARG_${name}})
		if(ARG_REMOVE)
			list(REMOVE_ITEM ARGV ${name})
			list(REMOVE_ITEM ARGV ${ARG_${name}})
			dk_warn("${CMAKE_CURRENT_FUNCTION}(${name} ${ARG_${name}}) REMOVED")
		endif()
	else()
		unset(${name})
		#message(STATUS "${CMAKE_CURRENT_FUNCTION}(): ${name}=OFF")
	endif()
endmacro()