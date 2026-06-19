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
# dk_executable(Plugin_name)
#
#	TODO
#
#	@Plugin_name	- TODO
#
function(dk_executable Plugin_name)
	dk_debugFunc()
	
	dk_getImportPath(${Plugin_name} PLUGIN_Import_Path)
	if(NOT EXISTS "${PLUGIN_Import_Path}")
		dk_fatal("${Plugin_name} Plugin NOT FOUND")
	endif()
	#dk_include(${PLUGIN_Import_Path})
	dk_include(${Plugin_name})
	dk_delete(${PLUGIN_Import_Path}/CMakeLists.txt)
	if(NOT EXISTS "${PLUGIN_Import_Path}/CMakeLists.txt")
	#dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "### ${Plugin_name} ###\n")
	#dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	#dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKFunctions.cmake)\n")
	#dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKVariables.cmake)\n")
	#dk_fileAppend(${PLUGIN_Import_Path}/CMakeLists.txt "project(${Plugin_name})\n")
	endif()
	dk_addToPluginList(${Plugin_name})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()