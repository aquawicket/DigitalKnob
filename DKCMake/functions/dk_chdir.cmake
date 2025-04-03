#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_chdir(directory)
#
#
function(dk_chdir directory)
	dk_debugFunc()
  
	#dk_assertPath(directory)
	if(NOT EXISTS ${directory})
		dk_warning("dk_chdir(${ARGV}): directory:${directory} does not exist")
		return()
	endif()
	
	if("${PWD}" EQUAL "${directory}")
		dk_error("dk_chdir(${directory}): PWD is already set to ${directory}")
	endif()
	
	dk_set(OLDPWD "${PWD}")
	dk_set(PWD "${directory}")
	dk_info("dk_chdir(${directory}): working directory set to ${directory}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(ENV{DKDOWNLOAD_DIR} "dk_DKDOWNLOAD_DIR()")
	dk_chdir($ENV{DKDOWNLOAD_DIR})
endfunction()
