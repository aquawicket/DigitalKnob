include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

# FIXME:  not working
###############################################################################
# dk_getFilename(path rtn_var)
#
#	Get the filename portion of a path
#
#	@path		- The path to use
#	@rtn_var:	- Returns the file name upon success: False upon error
#
function(dk_getFilename path rtn_var)
	dk_debugFunc(${ARGV})
	
	dk_assert(path)
	dk_assert(rtn_var)
	
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
		dk_warning("dk_getFilename(${path}) failed: Now using dk_basename() to retrieve the filename")
		dk_basename("${path}" filename)
	endif()
	
	dk_assert(filename)
	dk_printVar(filename)
    set(${rtn_var} ${filename} PARENT_SCOPE)
endfunction()




function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()