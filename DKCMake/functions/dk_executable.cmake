include_guard()

###############################################################################
# dk_executable(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_executable plugin_name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_error("${plugin_name} plugin not found")
	endif()
	#dk_include(${plugin_path})
	dk_include(${plugin_name})
	dk_remove(${plugin_path}/CMakeLists.txt)
	if(NOT EXISTS "${plugin_path}/CMakeLists.txt")
	#file(APPEND ${plugin_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKFunctions.cmake)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKVariables.cmake)\n")
	#file(APPEND ${plugin_path}/CMakeLists.txt "project(${plugin_name})\n")
	endif()
	dk_addToPluginList(${plugin_name})
endfunction()