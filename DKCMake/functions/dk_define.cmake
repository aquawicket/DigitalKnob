include_guard()

###############################################################################
# dk_define(str)
#
#	TODO
#
#	@str	- TODO
#
function(dk_define str)
	DKDEBUGFUNC(${ARGV})
	if(CMAKE_SCRIPT_MODE_FILE)
		return()
	endif()
	list(FIND DKDEFINES_LIST "${str}" index)
	if(${index} GREATER -1)
		return() # already in the list
	endif()
	dk_set(DKDEFINES_LIST ${DKDEFINES_LIST} ${str})
	add_definitions(-D${str})
endfunction()
dk_createOsMacros("dk_define")
