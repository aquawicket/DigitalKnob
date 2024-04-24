include_guard()

###############################################################################
# dk_addSource(regex)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_addSource regex)
	DKDEBUGFUNC(${ARGV})
	
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
endfunction()