include_guard()

###############################################################################
# dk_removeTarget(plugin target)
#
#	TODO
#
#	@plugin		- TODO
#	@target		- TODO
#
function(dk_removeTarget plugin target)
	dk_debugFunc(${ARGV})

	if(${plugin}_targets)
		list(REMOVE_ITEM ${plugin}_targets ${target})
	endif()
	if(${plugin}_targets_OFF)
		dk_set(${plugin}_targets_OFF ${${plugin}_targets_OFF} ${target})
	else()
		dk_set(${plugin}_targets_OFF ${target})
	endif()
	dk_set(${plugin}_${target} 0)
	dk_unset(${plugin}_${target})
	#dk_unset(${plugin}::${target}) # TESTME
endfunction()