include_guard()

###############################################################################
# dk_getParameter(name RESULT ${ARGV})
#
#	get a parameter by name from within a function
#
#	@name		-The input MARKER name for the parameter
#	@RESULT	-The value of the next parameter after the MARKER
#	${ARGV}		-The arg list from the calling function
#
macro(dk_getParameter name RESULT)
	#DKDEBUGFUNC(${ARGV})
	#dk_debug("ARGV = ${ARGV}")
	#dk_debug("ARGN = ${ARGN}")
	set(index 0)
	foreach(arg ${ARGN})
		#dk_debug(index PRINTVAR)
		#dk_debug(arg PRINTVAR)
		#dk_debug("ARGV${index} = ${ARGV${index}}")
		if("${ARGV${index}}" STREQUAL "${name}")
		#if("${arg}" STREQUAL "${name}")
			math(EXPR value "${index}+1")
			set(${RESULT} ${ARGV${value}})
			#dk_debug("dk_getParameter(${name}) = ${${RESULT}}")
		endif()
		math(EXPR index "${index}+1")
	endforeach()
	#dk_debug("dk_getParameter(${name}) = ${${RESULT}}")
endmacro()