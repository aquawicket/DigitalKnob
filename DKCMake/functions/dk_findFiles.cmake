include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_findFiles(path pattern rtn_var) RECURSE
#
#	Search for files within a path matching a pattern
#
#	@path				- The path to search 
#	@pattern			- The pattern to search for
#	@rtn_var				- Returns the list of file(s) if found
#   RECURSE (optional) 	- Search the path recursivly 
#
function(dk_findFiles path pattern rtn_var)
	dk_debugFunc(${ARGV})
	
	dk_getOption(RECURSE ${ARGV})

	if(RECURSE)
		file(GLOB_RECURSE findFiles "${path}/" "${path}/${pattern}")
	else()
		file(GLOB findFiles "${path}/" "${path}/${pattern}")
	endif()
	if(NOT findFiles)
		dk_error("findFiles is invalid")
		return()
	endif()
	dk_printVar(findFiles)
	set(${rtn_var} ${findFiles} PARENT_SCOPE)
endfunction()






function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)