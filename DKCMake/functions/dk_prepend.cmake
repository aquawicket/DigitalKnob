include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_prepend(<variable> <value>)
#
#	<variable>	- The name of a variable to declare
#	<value>		- The value to add to the variable.
#
function(dk_prepend variable) #value
	dk_debugFunc(${ARGV})
	
	if(NOT ARGN)
		dk_warning("dk_prepend(${variable}) ARGN:${ARGN} is invalid")
		return()
	endif()
	if(${variable})
		dk_set(${variable} ${ARGN} ${${variable}})
	else()
		dk_set(${variable} ${ARGN})
	endif()
	
endfunction()
dk_createOsMacros("dk_prepend")






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)