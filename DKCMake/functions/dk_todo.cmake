include_guard()

###############################################################################
# dk_todo(msg)
#
#	print a TODO message and wait 10 seconds
#
#	@msg (optional)	- A header message to print
#
macro(dk_todo)
	#DKDEBUGFUNC(${ARGV})
	if(DKTODO_ENABLED)
		if(${ARGV})
			set(msg "TODO: ${ARGV0}")
		else()
			set(msg "TODO:")
		endif()
		dk_debug(msg)
		#dk_wait(10)
	endif()
endmacro()