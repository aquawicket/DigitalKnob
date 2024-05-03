include_guard()

###############################################################################
# dk_validate(variable "code")
#
#	@variable  - The name of a variable to test
#	@code	   - The code to run if the variable is invalid. Like a function "dk_getDKPaths()"
#
function(dk_validate variable code)
	dk_debugFunc(${ARGV})
	
	if(NOT variable)
		dk_warning("dk_append(${variable} ${code}) variable is invalid")
		return()
	endif()
	if(NOT code)
		dk_warning("dk_append(${variable} ${code}) code is invalid")
		return()
	endif()
	
	if(${variable})
		return()
	endif()
	
	dk_eval("${code}")
	
	DK_ASSERT(${variable})
endfunction()
#dk_createOsMacros("dk_validate")
