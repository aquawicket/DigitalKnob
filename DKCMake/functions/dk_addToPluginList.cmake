#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_addToPluginList(<plugin_name>)
#
#	<plugin_name>	- TODO
#
function(dk_addToPluginList plugin_name)
	dk_debugFunc(1)
	
	dk_getPathToPlugin(${plugin_name} Plugin_Path)
	if(NOT EXISTS "${Plugin_Path}")
		dk_fatal("${plugin_name} plugin not found")
	endif()
	dk_include(${Plugin_Path})
	dk_append(DKPLUGIN_LIST "${plugin_name}")
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_addToPluginList(todo) # TODO
endfunction()
