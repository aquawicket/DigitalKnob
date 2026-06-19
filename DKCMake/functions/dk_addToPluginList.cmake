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
# dk_addToPluginList(<Plugin_name>)
#
#	<Plugin_name>	- TODO
#
function(dk_addToPluginList PLUGIN_Import_Name)
	dk_debugFunc(1)
	
	dk_getImportPath(${PLUGIN_Import_Name} PLUGIN_Import_Path)
	if(NOT EXISTS "${PLUGIN_Import_Path}")
		dk_fatal("${PLUGIN_Import_Name} Plugin NOT FOUND")
	endif()
	dk_include(${PLUGIN_Import_Path})
	dk_append(DKPLUGIN_LIST "${PLUGIN_Import_Name}")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_addToPluginList(zlib) # TODO
endfunction()
