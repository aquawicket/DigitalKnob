#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# dk_pathExists(path)
#
#	Check if a case sensitive path exists
#
function(dk_pathExists)
	dk_debugFunc()
	
	set(dk_pathExists true)
	
	get_filename_component(realPath "${ARGV0}" REALPATH)
	if(NOT "${realPath}" STREQUAL "${ARGV0}")
		set(dk_pathExists false)
	endif()		
	if(NOT EXISTS "${ARGV0}")
		set(dk_pathExists false)
	endif()
	
	###### return ######
	set(dk_pathExists ${dk_pathExists} PARENT_SCOPE)
	if(${ARGC} GREATER 1)
		set(${ARGV1} ${dk_pathExists} PARENT_SCOPE)
	endif()
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