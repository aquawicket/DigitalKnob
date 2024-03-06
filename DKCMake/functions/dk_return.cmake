include_guard()

###############################################################################
# dk_return()
#
#	Print the current cmake file and return
#
macro(dk_return)
	#DKDEBUGFUNC(${ARGV})
	if(PRINT_DKRETURNS)
		message(STATUS "${CMAKE_CURRENT_LIST_FILE} -> dk_return()")
	endif()
	return()
endmacro()
dk_createOsMacros("dk_return")
