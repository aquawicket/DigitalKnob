include_guard()

###############################################################################
# dk_undefine(str)
#
#	TODO
#
#	@str	- TODO
#
function(dk_undefine str)
	DKDEBUGFUNC(${ARGV})
	remove_definitions(${str})
	if(NOT DKDEFINES_LIST)
		return()
	endif()
	list(REMOVE_ITEM DKDEFINES_LIST ${str})
endfunction()