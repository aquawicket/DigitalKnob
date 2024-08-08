include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_getParameter(name rtn_var) ${ARGV}
#
#	get a parameter by name from within a function
#
#	@name		-The input MARKER name for the parameter
#	@rtn_var		-The value of the next parameter after the MARKER
#	${ARGV}		-The arg list from the calling function
#
macro(dk_getParameter name rtn_var)
	dk_debugFunc(${ARGV})
	
	dk_getOptionValue(${name} ${ARGN})
	dk_printVar(${name})
	set(${rtn_var} ${${name}})
endmacro()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()