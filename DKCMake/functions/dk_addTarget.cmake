include_guard()

###############################################################################
# dk_addTarget(plugin target)
#
#	TODO
#
#	@plugin		- TODO
#	@target		- TODO
#
function(dk_addTarget plugin target)
	DKDEBUGFUNC(${ARGV})
	dk_verbose("dk_addTarget( ${ARGV} )")
	if(${plugin}_targets_OFF)
		list(REMOVE_ITEM ${plugin}_targets_OFF ${target})
	endif()
	if(${plugin}_targets)
		dk_set(${plugin}_targets ${${plugin}_targets} ${target})
	else()
		dk_set(${plugin}_targets ${target})
	endif()
	if(${plugin}_all)
		dk_set(${plugin}_${target} ON)
		#dk_set(${plugin}::${target} ON) # TESTME
	endif()
endfunction()