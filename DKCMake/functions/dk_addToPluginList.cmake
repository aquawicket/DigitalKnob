include(${CMAKE_CURRENT_LIST_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_add_to_plugin_list(plugin_name)
#
#	TODO
#
#	@plugin_name	- TODO
#
function(dk_add_to_plugin_list plugin_name)
	dk_debugFunc(${ARGV})
	
	dk_getPathToPlugin(${plugin_name} plugin_path)
	if(NOT EXISTS "${plugin_path}")
		dk_error("${plugin_name} plugin not found")
	endif()
	dk_include(${plugin_path})
	dk_set(DKPLUGIN_LIST ${DKPLUGIN_LIST} ${plugin_name})
endfunction()