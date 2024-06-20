include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()


##################################################################################
# dk_getFullPath(path, rtn_var)
#
#
function(dk_getFullPath path rtn_var)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 2)
		dk_error("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	get_filename_component(fullpath ${path} ABSOLUTE)
	#get_filename_component(fullpath ${path} REALPATH)
	dk_printVar(fullpath)
	set(${rtn_var} ${fullpath} PARENT_SCOPE)
endfunction()



function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	dk_getFullPath("bash" fullPath)
	dk_info("fullPath = ${fullPath}")
endfunction()