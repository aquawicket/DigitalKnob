#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
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
	
	dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
	dk_chdir(DKDOWNLOAD_DIR)
endfunction()
