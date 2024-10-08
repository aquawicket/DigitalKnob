include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_pathContains(expression rtn_var)
#
#	@expression	- The search expression to use. Example: "${path}/subfolder/*.exe"
#   @rtn_var		- Returns TRUE if the expression is found
#
function(dk_pathContains expression rtn_var)
	dk_debugFunc("\${ARGV}")
	
	file(GLOB glob_var "${expression}")
	if(glob_var)
		set(${pathContains} TRUE)
	endif()
	
	#dk_printVar(pathContains)
	set(${rtn_var} ${pathContains} PARENT_SCOPE)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_todo()
endfunction()