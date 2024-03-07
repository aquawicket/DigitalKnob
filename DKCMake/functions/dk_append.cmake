include_guard()

###############################################################################
# dk_append(variable value)
#
#	@variable	- The name of a variable to declaire
#	@value		- The value to add to the variable.
#
function(dk_append variable) #value
	DKDEBUGFUNC(${ARGV})
	if(NOT ARGN)
		dk_warn("dk_append(${variable}) ARGN:${ARGN} is invalid")
		return()
	endif()
	if(${variable})
		dk_set(${variable} ${${variable}} ${ARGN})
	else()
		dk_set(${variable} ${ARGN})
	endif()
	
endfunction()
dk_createOsMacros("dk_append")
