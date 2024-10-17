#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_add_to_plugin_list(<plugin_name>)
#
#	<plugin_name>	- TODO
#
function(dk_add_to_plugin_list plugin_name)
	dk_debugFunc()
	
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_fatal("${plugin_name} plugin not found")
	endif()
	dk_include(${plugin_path})
	dk_append(DKPLUGIN_LIST "${plugin_name}")
	
# DEBUG
#	dk_printVar(DKPLUGIN_LIST)
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_todo()
endfunction()
