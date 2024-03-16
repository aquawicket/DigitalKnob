include_guard()

###############################################################################
# dk_queueBash(args)
#
#	TODO
#
#	@args	- TODO
#
function(dk_queueBash)
	DKDEBUGFUNC(${ARGV})
	if(QUEUE_BUILD)
		dk_bash(${ARGV})
	endif()	
endfunction()
dk_createOsMacros("dk_queueBash")