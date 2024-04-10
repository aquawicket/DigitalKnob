include_guard()

# FIXME:  not working
###############################################################################
# dk_getFilename(path RESULT)
#
#	Get the filename portion of a path
#
#	@path		- The path to use
#	@RESULT:	- Returns the file name upon success: False upon error
#
function(dk_getFilename path RESULT)
	DKDEBUGFUNC(${ARGV})
	DK_ASSERT(path)
	DK_ASSERT(RESULT)
	
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		dk_error("No Path Dividers found")
	endif()
	MATH(EXPR index "${index}+1")
	string(LENGTH ${path} length)
	if(${index} EQUAL ${length})
		dk_warning("dk_getFilename(${path}) last character in path was a /")
	endif()
	
	string(SUBSTRING ${path} ${index} -1 filename) 
	
	if(NOT filename)
		dk_warning("dk_getFilename(${path}) failed: using get_filename_component() to retrieve the filename")
		get_filename_component(filename "${path}" NAME)
		dk_debug("filename = ${filename}")
	endif()
	
	DK_ASSERT(filename)
    set(${RESULT} ${filename} PARENT_SCOPE)
endfunction()