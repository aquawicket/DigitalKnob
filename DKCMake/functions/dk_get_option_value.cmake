include_guard()

###############################################################################
# dk_get_option_value(name ${ARGV}) 
#
#	TODO: change to dk_get_option_value(name output ${ARGV}) so we can choose the variable to recieve the option in
#
#	EXAMPLE: dk_get_option_value(MY_ARG ${ARGV})
#
function(dk_get_option_value name)
	cmake_parse_arguments(ARG "" "${name}" "" ${ARGN})
	cmake_parse_arguments(ARG REMOVE "" "" ${ARGN})
	#dk_print_prefix_vars("ARG_")
	if(ARG_${name})
		set(${name} ${ARG_${name}} PARENT_SCOPE)
		if(ARG_REMOVE)
			set(ARG_LIST ${ARGN})
			list(REMOVE_ITEM ARG_LIST ${name})
			list(REMOVE_ITEM ARG_LIST ${ARG_${name}})
			list(REMOVE_ITEM ARG_LIST REMOVE)
			set(ARGV ${ARG_LIST} PARENT_SCOPE)
			#dk_notice("${CMAKE_CURRENT_FUNCTION}(${name} ${ARG_${name}}) REMOVED")
			dk_notice("${name} REMOVED")
		endif()
	else()
		unset(${name})
		#message(STATUS "${CMAKE_CURRENT_FUNCTION}(): ${name}=OFF")
	endif()
endfunction()