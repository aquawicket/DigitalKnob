include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_getDirectory(path rtn_var)
#
#	Get the directory portion of a path
#
#	@path		- The path to use
#	@rtn_var		- Returns the directory upon success: False upon error
#
function(dk_getDirectory path rtn_var)
	dk_debugFunc(${ARGV})
	
	string(FIND ${path} "/" index REVERSE)
	if(${index} EQUAL -1)
		return() # no path dividers found
	endif()
	string(SUBSTRING ${path} 0 ${index} directory)
	dk_printVar(directory)
    set(${rtn_var} ${directory} PARENT_SCOPE)
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######

	dk_todo()

endfunction(DKTEST)