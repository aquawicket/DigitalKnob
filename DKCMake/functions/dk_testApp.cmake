include_guard()

###############################################################################
# dk_testApp(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_testApp plugin_name)
	DKDEBUGFUNC(${ARGV})
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}/test")
		dk_info("dk_testApp(): ${plugin_name}_test app not found")
		return()
	endif()
	dk_info("building ${plugin_name}_test app")
	dk_set(test_path "${plugin_path}/test")
	
	# Create CmakeLists.txt file
	dk_remove("${test_path}/CMakeLists.txt")
	file(APPEND ${test_path}/CMakeLists.txt "### This file is generated by DKCMake. Any Changes here, will be overwritten. ###\n")
	file(APPEND ${test_path}/CMakeLists.txt "### ${plugin_name} ###\n")
	file(APPEND ${test_path}/CMakeLists.txt "cmake_minimum_required(VERSION 3.10)\n")
	file(APPEND ${test_path}/CMakeLists.txt "cmake_policy(SET CMP0054 NEW)\n")
	file(APPEND ${test_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKFunctions.cmake)\n")
	file(APPEND ${test_path}/CMakeLists.txt "include(${DKCMAKE_DIR}/DKVariables.cmake)\n")
	dk_appendCmake("project(${plugin_name}_test)\n")
	dk_appendCmake("include_directories(${DKPLUGINS_DIR})\n")
		
	# TODO		
	dk_addToPluginList(${plugin_name})
endfunction()