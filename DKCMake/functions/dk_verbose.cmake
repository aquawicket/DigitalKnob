include_guard()

if(NOT DEFINED ENABLE_dk_verbose)
	dk_set(ENABLE_dk_verbose 0)
endif()
##################################################################################
# dk_verbose(msg)
#
#	Print a verbose message to the console
#
#	@msg	- The message to print
#
function(dk_verbose msg)
	#DKDEBUGFUNC(${ARGV})
	
	if(ENABLE_dk_verbose)
		dk_printvar(msg)
		
		dk_updateLogInfo()
		message(VERBOSE "${H_black}${STACK_HEADER}${clr}${cyan} ${msg} ${clr}")
	endif()
endfunction()
