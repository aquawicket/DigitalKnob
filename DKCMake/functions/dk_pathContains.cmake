include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_pathContains(expression rtn_var)
#
#	@expression	- The search expression to use. Example: "${path}/subfolder/*.exe"
#   @rtn_var		- Returns TRUE if the expression is found
#
function(dk_pathContains expression rtn_var)
	dk_debugFunc(${ARGV})
	
	file(GLOB pathContains "${expression}")
	dk_printVar(pathContains)
	if(contains)
		set(${rtn_var} TRUE PARENT_SCOPE)
		return()
	endif()
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)