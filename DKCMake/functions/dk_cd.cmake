include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
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
	
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_cd(${DKDOWNLOAD_DIR})
endfunction()
