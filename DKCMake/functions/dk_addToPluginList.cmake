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
# dk_addToPluginList(<PLUGIN_Import_Name>)
#
#	<PLUGIN_Import_Name>	- TODO
#
function(dk_addToPluginList PLUGIN_Import_Name)
	dk_debugFunc(1)
	
	dk_getPathToPlugin(${PLUGIN_Import_Name} Plugin_Path)
	if(NOT EXISTS "${Plugin_Path}")
		dk_fatal("${PLUGIN_Import_Name} plugin not found")
	endif()
	dk_include(${Plugin_Path})
	dk_append(DKPLUGIN_LIST "${PLUGIN_Import_Name}")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_addToPluginList(zlib) # TODO
endfunction()
