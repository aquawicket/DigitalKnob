include_guard()

###############################################################################
# dk_findFiles(path pattern) RECURSE RELATIVE
#
#	Search for a file using a pattern I.E. *.txt
#
#	@pattern		- The pattern to search for
#
function(dk_findFiles path pattern RESULT)
	DKDEBUGFUNC(${ARGV})
	
	dk_includes("${ARGN}" "RECURSE" recurse)
	if(${recurse})
		file(GLOB_RECURSE files "${path}/" "${path}/${pattern}")
	else()
		file(GLOB files "${path}/" "${path}/${pattern}")
	endif()
	if(NOT files)
		dk_error("files is invalid")
		return()
	endif()
	dk_debug(files	PRINTVAR)
	set(${RESULT} ${files} PARENT_SCOPE)
endfunction()