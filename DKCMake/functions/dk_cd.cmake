#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_cd(directory)
#
#
function(dk_cd directory)
	dk_debugFunc("\${ARGV}")
  
	dk_assertPath(directory)
	if("${PWD}" EQUAL "${directory}")
		dk_error("dk_cd(${directory}): PWD is already set to ${directory}")
	endif()
	dk_set(PWD "${directory}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(DKDOWNLOAD_DIR "dk_DIGITALKNOB_DIR()")
	dk_cd(${DKDOWNLOAD_DIR})
endfunction()
