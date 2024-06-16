include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_unset(variable)
#
#	https://cmake.org/cmake/help/latest/command/unset.html
#
#	Remove a variable definition. will become undefined. 
#
#	@variable	- The name of the variable to unset
#
function(dk_unset variable)
	dk_debugFunc(${ARGV})
	
	if(DEFINED CACHE{${variable}})  # The $CACHE{VAR} syntax can be used to do direct cache entry lookups
		unset(${variable} CACHE)
	endif()
	if(DEFINED ${variable})
		unset(${variable})
	endif()
	unset(${variable} PARENT_SCOPE)
	
endfunction()
dk_createOsMacros("dk_unset")




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)