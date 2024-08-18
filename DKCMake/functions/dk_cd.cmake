include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_cd(directory)
#
#
function(dk_cd directory)
	dk_debugFunc(${ARGV})
  
	if(NOT EXISTS ${directory})
		dk_notice("directory:${directory} does not exist.")
		dk_notice("Creating directory: ${directory})")
		dk_makeDirectory(${directory})
	endif()
	
	if(NOT EXISTS "${directory}")
		dk_error("directory:${directory} does not exist")
		return()
	endif()
	
	#dk_set(WORKING_DIRECTORY ${directory})
	dk_set(PWD ${directory})
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_validate(DKDOWNLOAD_DIR "dk_getDKPaths()")
	dk_cd(${DKDOWNLOAD_DIR})
endfunction()
