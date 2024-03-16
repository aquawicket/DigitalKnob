include_guard()

###############################################################################
# dk_get_option(name ${ARGV})  
#
#	TODO
#
#	EXAMPLE: dk_get_option(MY_ARG ${ARGV})
#
macro(dk_get_option name)
	cmake_parse_arguments(ARG ${name} "" "" ${ARGN})
	#message("${name} = ${ARG_${name}}")
	if(ARG_${name})
		set(${name} ${name})
		#message(STATUS "${CMAKE_CURRENT_FUNCTION}(): ${name}=ON")
	else()
		unset(${name})
		#message(STATUS "${CMAKE_CURRENT_FUNCTION}(): ${name}=OFF")
	endif()
	list(REMOVE_ITEM ARGV ${name})	# remove item from parents ARGV list
endmacro()