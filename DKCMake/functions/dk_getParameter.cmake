include_guard()

###############################################################################
# dk_getParameter(name RESULT) ${ARGV}
#
#	get a parameter by name from within a function
#
#	@name		-The input MARKER name for the parameter
#	@RESULT		-The value of the next parameter after the MARKER
#	${ARGV}		-The arg list from the calling function
#
macro(dk_getParameter name RESULT)
	#DKDEBUGFUNC(${ARGV})
	dk_get_option_value(${name} ${ARGN})
	set(${RESULT} ${${name}})
endmacro()