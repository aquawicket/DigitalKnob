include_guard()

###############################################################################
# dk_remove(path [NOERROR])
#
#	Remove a file or directory
#
#	@path		- The full path to the file or direcotory to remove
#   NOERROR     - if NOERROR is specified in the parameters, dk_error() messages will not be displayed
#
function(dk_remove path)
	DKDEBUGFUNC(${ARGV})
	dk_includes("${ARGN}" "NOERROR" has_NOERROR)
	if(${has_NOERROR})
		set(noerror true)
	endif()
	if(NOT EXISTS ${path})
		if(NOT noerror)
			dk_error("${path} does not exist")
		endif()
		return()
	endif()
	file(REMOVE_RECURSE ${path})
	if(EXISTS ${path})
		dk_error("failed to remove ${path}")
	endif()
endfunction()