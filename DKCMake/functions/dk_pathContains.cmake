include_guard()

###############################################################################
# dk_pathContains(expression RESULT)
#
#	@expression	- The search expression to use. Example: "${path}/subfolder/*.exe"
#   @RESULT		- Returns TRUE if the expression is found
#
function(dk_pathContains expression RESULT)
	DKDEBUGFUNC(${ARGV})
	FILE(GLOB contains "${expression}") 
	if(contains)
		set(${RESULT} TRUE PARENT_SCOPE)
		return()
	endif()
endfunction()