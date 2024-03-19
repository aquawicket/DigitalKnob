include_guard()

###############################################################################
# dk_get_option_values(name ${ARGV}) 
#
#	TODO
#
#	EXAMPLE: dk_get_option_values(MY_ARG ${ARGV})
#
macro(dk_get_option_values name)
	cmake_parse_arguments(ARG "" "" "${name}" ${ARGN})
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