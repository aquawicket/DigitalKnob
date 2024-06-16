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
	
	#set(${variable} "" CACHE INTERNAL "")
	unset(${variable})
	unset(${variable} PARENT_SCOPE)
	unset(${variable} CACHE)
endfunction()
dk_createOsMacros("dk_unset")




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)