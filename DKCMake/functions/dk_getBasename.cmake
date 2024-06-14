include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


##################################################################################
# dk_getBasename(path, rtn_var)
#
#
function(dk_getBasename path rtn_var)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 2)
		dk_error("${CMAKE_CURRENT_FUNCTION}(): incorrect number of arguments")
	endif()
	
	
	get_filename_component(basename ${path} NAME)
	dk_printVar(basename)
	set(${rtn_var} ${basename} PARENT_SCOPE)
endfunction()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	
	dk_getBasename("/path/to/a/filename.txt" basename)
	dk_echo("basename = ${basename}")
endfunction()