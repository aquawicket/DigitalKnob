include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

##################################################################################
# dk_realpath(path, rtn_var)
#
#    CMAKE: https://cmake.org/cmake/help/latest/command/get_filename_component.html
#
function(dk_realpath path rtn_var)
	dk_debugFunc(${ARGV})
	if(NOT ${ARGC} EQUAL 2)
		dk_fatal("${CMAKE_CURRENT_FUNCTION}(${ARGV}): incorrect number of arguments")
	endif()
	
	get_filename_component(_realpath_ ${path} REALPATH)
	#dk_printVar(_realpath_)
	set(${rtn_var} ${_realpath_} PARENT_SCOPE)
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) #
	dk_debugFunc(${ARGV})
	
	dk_realpath("bash" realpath)
	dk_info("realpath = ${realpath}")
endfunction()