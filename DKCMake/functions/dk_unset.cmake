include_guard()

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
