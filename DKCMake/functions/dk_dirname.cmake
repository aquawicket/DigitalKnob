include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_dirname(path, rtn_var)
#
#    https://en.wikipedia.org/wiki/Dirname
#
function(dk_dirname path rtn_var)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 2)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()

	
	get_filename_component(dirname "${path}" DIRECTORY)
	dk_printVar(dirname)
	set(${rtn_var} "${dirname}" PARENT_SCOPE)
endfunction()



function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc(${ARGV})
	
	
	dk_dirname("C:/Windows/System32" dirname)
	dk_info("dirname = ${dirname}")
endfunction()