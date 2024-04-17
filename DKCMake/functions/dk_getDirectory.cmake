include_guard()

###############################################################################
# dk_getDirectory(path RESULT)
#
#	Get the directory portion of a path
#
#	@path		- The path to use
#	@RESULT		- Returns the directory upon success: False upon error
#
function(dk_getDirectory path RESULT)
	DKDEBUGFUNC(${ARGV})
	
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
	#dk_includes(${path} "/" index REVERSE)
	#if(NOT ${index})
		return() # no path dividers found
	endif()
	string(SUBSTRING ${path} 0 ${index} directory) 
    set(${RESULT} ${directory} PARENT_SCOPE)
endfunction()