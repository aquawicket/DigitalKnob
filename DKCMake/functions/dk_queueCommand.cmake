include_guard()

###############################################################################
# dk_queueCommand(args) NOASSERT NOECHO NOMERGE
#
#	TODO
#
#	@args	- TODO
#
function(dk_queueCommand)
	DKDEBUGFUNC(${ARGV})
	dk_get_option(NOASSERT ${ARGV})
	dk_get_option(NOECHO ${ARGV})
	dk_get_option(NOMERGE ${ARGV})
	
	#dk_info("\n${CLR}${magenta} $ ${ARGV}\n")
	
	if(QUEUE_BUILD)
		dk_command(${ARGV})
	endif()	
endfunction()
dk_createOsMacros("dk_queueCommand")