include_guard()

###############################################################################
# dk_removeSource(regex)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_removeSource regex)
	dk_debugFunc(${ARGV})
	
	dk_set(SRC_EXCLUDE ${SRC_EXCLUDE} ${ARGV})
endfunction()