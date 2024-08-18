include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_executable(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_executable plugin_name)
	dk_debugFunc(${ARGV})
	
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_error("${plugin_name} plugin not found")
	endif()
	#dk_include(${plugin_path})
	dk_include(${plugin_name})
	dk_delete(${plugin_path}/CMakeLists.txt)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKFunctions.cmake)\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKVariables.cmake)\n")
	#dk_fileAppend(${plugin_path}/CMakeLists.txt "project(${plugin_name})\n")
	endif()
	dk_add_to_plugin_list(${plugin_name})
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()