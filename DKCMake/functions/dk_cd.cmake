#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_cd(directory)
#
#
function(dk_cd directory)
	dk_debugFunc()
  
	#dk_assertPath(directory)
	if(NOT EXISTS ${directory})
		dk_warning("dk_cd(${ARGV}): directory:${directory} does not exist")
		return()
	endif()
	
	if("${PWD}" EQUAL "${directory}")
		dk_error("dk_cd(${directory}): PWD is already set to ${directory}")
	endif()
	dk_set(PWD "${directory}")
	dk_info("dk_cd(${directory}): working directory set to ${directory}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")
	dk_cd(${DKDOWNLOAD_DIR})
endfunction()
