#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_addToPluginList(<plugin_name>)
#
#	<plugin_name>	- TODO
#
function(dk_addToPluginList plugin_name)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(1)
>>>>>>> Development
	
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
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_todo()
=======
	dk_debugFunc(0)
	
	dk_addToPluginList(todo) # TODO
>>>>>>> Development
endfunction()
