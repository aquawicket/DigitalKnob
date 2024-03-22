include_guard()

###############################################################################
# dk_dirIsEmpty(path RESULT)
#
#	Get weather or not a directory is empty
#
#	@path		- The full path to the directory to check
#	@RESULT		- Returns true if the directory is empty. False if the directory is not empty
#
function(dk_dirIsEmpty path RESULT)
	DKDEBUGFUNC(${ARGV})
	if(EXISTS ${path})
		file(GLOB items RELATIVE "${path}/" "${path}/*")
		list(LENGTH items count)
		if(${count} GREATER 0)
			set(${RESULT} false PARENT_SCOPE)
			return()
		endif()
	endif()
	set(${RESULT} true PARENT_SCOPE)
endfunction()