#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_executable(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_executable plugin_name)
	dk_debugFunc()
	
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_fatal("${plugin_name} plugin not found")
	endif()
	#dk_include(${plugin_path})
	dk_include(${plugin_name})
	dk_delete(${plugin_path}/CMakeLists.txt)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
<<<<<<< HEAD
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKFunctions.cmake)\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKVariables.cmake)\n")
=======
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "include($ENV{DKCMAKE_DIR}/DKFunctions.cmake)\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "include($ENV{DKCMAKE_DIR}/DKVariables.cmake)\n")
>>>>>>> Development
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "project(${plugin_name})\n")
	endif()
	dk_addToPluginList(${plugin_name})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()