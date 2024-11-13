#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_getParameter(name rtn_var) ${ARGV}
#
#	get a parameter by name from within a function
#
#	@name		-The input MARKER name for the parameter
#	@rtn_var	-The value of the next parameter after the MARKER
#	${ARGV}		-The arg list from the calling function
#
macro(dk_getParameter name rtn_var)
	dk_debugFunc()
	
	dk_getOptionValue(${name} ${ARGN})
	set(${rtn_var} ${${name}})
	
# DEBUG
#	dk_printVar(${name})
endmacro()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_getParameter(TODO value ${ARGV})
	dk_printVar(value)
endfunction()