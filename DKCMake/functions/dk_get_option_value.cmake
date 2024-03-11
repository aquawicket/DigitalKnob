include_guard()

###############################################################################
# dk_get_option_value(name ${ARGV}) 
#
#	TODO
#
#	EXAMPLE: dk_get_option_value(MY_ARG ${ARGV})
#
macro(dk_get_option_value name)
	cmake_parse_arguments(ARG "" "${name}" "" ${ARGN})
	#dk_print_prefix_vars("ARG_")
	set(${name} ${ARG_${name}})
	list(REMOVE_ITEM ARGV ${name})
	list(REMOVE_ITEM ARGV ${ARG_${name}})
endmacro()