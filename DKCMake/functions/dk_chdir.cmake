#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################


#########################################################################
if(NOT PWD)
	dk_set(PWD "${CMAKE_CURRENT_LIST_DIR}")
endif()
#########################################################################
# dk_chdir(path)
#
#	change working directory
#
function(dk_chdir)
	dk_debugFunc(1)
  
	set(_path_ ${ARGV0})
  
	if(NOT EXISTS ${_path_})
		dk_warning("dk_chdir(${ARGV}): path:${_path_} does not exist")
		return()
	endif()
	
	if("${PWD}" EQUAL "${_path_}")
		dk_error("dk_chdir(${ARGV}): PWD is already set to ${_path_}")
		return()
	endif()
	
	dk_set(OLDPWD "${PWD}")
	dk_set(PWD "${_path_}")
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("OLD Current Directory = ${OLDPWD}")
	dk_echo("Current Directory = ${PWD}")
	
	dk_echo()
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	dk_chdir("${DKBRANCH_DIR}")
	dk_echo("OLD Current Directory = ${OLDPWD}")
	dk_echo("Current Directory = ${PWD}")
	
	dk_echo()
	dk_validate(DKTOOLS_DIR "dk_DKTOOLS_DIR()")
	dk_chdir("${DKTOOLS_DIR}")
	dk_echo("OLD Current Directory = ${OLDPWD}")
	dk_echo("Current Directory = ${PWD}")
endfunction()
