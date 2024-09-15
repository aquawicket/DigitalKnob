include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_cd(directory)
#
#
function(dk_cd directory)
	dk_debugFunc("\${ARGV}")
  
	if(NOT EXISTS "${directory}")
		dk_fatal("directory:${directory} does not exist")
		return()
	endif()
	
	if("${PWD}" EQUAL "${directory}")
		dk_error("dk_cd(${directory}): PWD is already set to ${directory}")
	endif()
	
	dk_set(PWD ${directory})

#debug
#	dk_debug("Working Dirctory set to: ${PWD}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_cd(${DKDOWNLOAD_DIR})
endfunction()
