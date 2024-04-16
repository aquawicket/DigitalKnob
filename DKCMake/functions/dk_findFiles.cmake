include_guard()

###############################################################################
# dk_findFiles(path pattern RESULT) RECURSE
#
#	Search for files within a path matching a pattern
#
#	@path				- The path to search 
#	@pattern			- The pattern to search for
#	@RESULT				- Returns the list of file(s) if found
#   RECURSE (optional) 	- Search the path recursivly 
#
function(dk_findFiles path pattern RESULT)
	DKDEBUGFUNC(${ARGV})
	dk_get_option(RECURSE ${ARGV})

	if(RECURSE)
		file(GLOB_RECURSE files "${path}/" "${path}/${pattern}")
	else()
		file(GLOB files "${path}/" "${path}/${pattern}")
	endif()
	if(NOT files)
		dk_error("files is invalid")
		return()
	endif()
	dk_debug(files)
	set(${RESULT} ${files} PARENT_SCOPE)
endfunction()