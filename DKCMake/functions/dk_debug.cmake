include_guard()

##################################################################################
# dk_debug(msg)
#
#	Print a debug message to the console
#
#	@msg	- The message to print
#
function(dk_debug msg)
	#DKDEBUGFUNC(${ARGV})
	#message("dk_debug(${ARGV})")
	
	if(NOT DKDEBUG_ENABLED)
		return()
	endif()
		
	dk_printvar(msg)
		
	#dk_updateLogInfo()
	#message(DEBUG "${H_black}${STACK_HEADER}${clr}${blue} ${msg} ${clr}")

	message("${blue}${msg}${clr}")
endfunction()
