include_guard()
message(STATUS "****** LOADING: ${CMAKE_CURRENT_LIST_FILE} ******")


###############################################################################
# dk_unset(variable)
#
#	Remove a variable definition. will become undefined. 
#
#	@variable	- The name of the variable to unset
#
function(dk_unset variable)
	DKDEBUGFUNC(${ARGV})
	set(${variable} "" CACHE INTERNAL "")
	unset(${variable})
endfunction()
dk_createOsMacros("dk_unset")
