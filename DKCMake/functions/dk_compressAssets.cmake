include_guard()

###############################################################################
# dk_compressAssets(path)
#
#	Compress a path to a assets.zip archive
#
#	@path	- The full path to add to the archive file
#
function(dk_compressAssets path)
	dk_debugFunc(${ARGV})
	
	dk_info("Compressing: ${path}")
	if(NOT EXISTS ${path})
		dk_error("The path ${path} does not exist")
	endif()
	execute_process(COMMAND ${CMAKE_COMMAND} -E tar "cfv" "${DK_PROJECT_DIR}/assets.zip" --format=zip "." WORKING_DIRECTORY ${path}/)
endfunction()
