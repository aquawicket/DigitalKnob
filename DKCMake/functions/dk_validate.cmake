include_guard()

###############################################################################
# dk_validate(variable func)
#
#	@variable  - The name of a variable to test
#	@func	   - The function to run if the variable is invalid.
#
function(dk_validate variable func)
	dk_debugFunc(${ARGV})
	
	if(NOT variable)
		dk_warning("dk_append(${variable} ${func}) variable is invalid")
		return()
	endif()
	if(NOT func)
		dk_warning("dk_append(${variable} ${func}) func is invalid")
		return()
	endif()
	
	if(${variable})
		return()
	endif()
	
	dk_eval("${func}()")
	
endfunction()
#dk_createOsMacros("dk_validate")
