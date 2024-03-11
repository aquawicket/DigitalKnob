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
	#dk_print_prefix_vars("ARG_")
	set(${name} ${ARG_${name}})
	list(REMOVE_ITEM ARGV ${name})
	list(REMOVE_ITEM ARGV ${ARG_${name}})
	#FIXME: TODO:  remove each value from ARGV
endmacro()