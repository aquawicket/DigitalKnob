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
# dk_pathExists(path) rtn_var
#
#
function(dk_pathExists)
	dk_debugFunc()
	
	set(pathExists true)
	
	get_filename_component(realPath "${ARGV0}" REALPATH)
	if(NOT "${realPath}" STREQUAL "${ARGV0}")
		set(pathExists false)
	endif()		
	if(NOT EXISTS "${ARGV0}")
		set(pathExists false)
	endif()
	
	set(dk_pathExists ${pathExists} PARENT_SCOPE)
	
#	if(${ARGC} GREATER 1)
#		set(${rtn_var} ${pathExists} PARENT_SCOPE)
#	endif()
endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST) 
	dk_debugFunc(0)
	
	dk_pathExists("C:/Windows/System32")
	if(dk_pathExists)
		dk_info("The path exists")
	else()
		dk_info("The path does NOT exist")
	endif()
	
	dk_pathExists("C:/windows/system32")
	if(dk_pathExists)
		dk_info("The path exists")
	else()
		dk_info("The path does NOT exist")
	endif()
	
	dk_pathExists("${PWD}")
	if(dk_pathExists)
		dk_info("The path exists")
	else()
		dk_info("The path does NOT exist")
	endif()
endfunction()