include_guard()

###############################################################################
# dk_assets(plugin)
#
#	Add a library's files to the App's assets
#
#	@plugin		- TODO
#
function(dk_assets plugin)
	DKDEBUGFUNC(${ARGV})
	if(NOT DKAPP)
		return()
	endif()	
	dk_getPathToPlugin(${plugin} plugin_path)
	if(NOT plugin_path)
		dk_error("${plugin} plugin not found")
	endif()
	dk_info("Importing ${plugin} assets...")
	file(COPY ${plugin_path} DESTINATION ${DK_PROJECT_DIR}/assets ${ASSETS})
	#file(COPY ${plugin_path}/${OS}/${DEBUG_DIR}/*.exe DESTINATION ${DK_PROJECT_DIR}/assets/${OS}/Debug)
endfunction()