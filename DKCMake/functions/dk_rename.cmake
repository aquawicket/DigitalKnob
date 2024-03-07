include_guard()

###############################################################################
# dk_rename(from to) OVERWRITE NOERROR
#
#	Rename file or directory or move a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#   NOERROR     - if any of the parameters equals NOERROR, dk_error() messages will not be displayed
#
function(dk_rename from to) # FLAGS: OVERWRITE, NOERROR
	DKDEBUGFUNC(${ARGV})
	dk_includes("${ARGN}" "OVERWRITE" includes)
	if(${includes})
		set(overwrite true)
	endif()
	dk_includes("${ARGN}" "NOERROR" includes)
	if(${includes})
		set(noerror true)
	endif()
	dk_info("Renameing ${from} to ${to}")
	if(NOT EXISTS ${from})
		if(NOT noerror)
			dk_error("from:${from} not found")
		endif()
		return()
	endif()
	if(EXISTS ${to})
		if(NOT ${overwrite})
			dk_error("Cannot rename file. Destiantion exists and not set to overwrite")
		endif()
		dk_remove(${to})
	endif()
	file(RENAME ${from} ${to})
endfunction()
dk_createOsMacros("dk_rename")
