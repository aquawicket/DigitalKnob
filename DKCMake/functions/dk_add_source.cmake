include_guard()

###############################################################################
# dk_add_source(regex)
#
#	TODO
#
#	@regex	- TODO
#
function(dk_add_source regex)
	DKDEBUGFUNC(${ARGV})
	
	dk_set(SRC_INCLUDE ${SRC_INCLUDE} ${ARGV})
endfunction()