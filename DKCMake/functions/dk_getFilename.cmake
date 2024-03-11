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
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
	#dk_includes(${path} "/" index REVERSE)
	#if(NOT ${index})
		dk_error("No Path Dividers found")
	endif()
	MATH(EXPR index "${index}+1")
	string(SUBSTRING ${path} ${index} -1 filename) 
    set(${RESULT} ${filename} PARENT_SCOPE)
endfunction()