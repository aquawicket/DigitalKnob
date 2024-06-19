include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_dirIsEmpty(path <rtn_var>)
#
#	Get weather or not a directory is empty
#
#	<path>		- The full path to the directory to check
#	<rtn_var>	- Returns true if the directory is empty. False if the directory is not empty
#
function(dk_dirIsEmpty path rtn_var)
	dk_debugFunc(${ARGV})
	
	if(EXISTS ${path})
		file(GLOB items RELATIVE "${path}/" "${path}/*")
		list(LENGTH items count)
		if(${count} GREATER 0)
			set(dirIsEmpty false)
		else()
			set(dirIsEmpty true)
		endif()
	else()
		set(dirIsEmpty true)
	endif()
	dk_printVar(dirIsEmpty)
	set(${rtn_var} ${dirIsEmpty} PARENT_SCOPE)
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)