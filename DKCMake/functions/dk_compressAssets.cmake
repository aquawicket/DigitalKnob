#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_compressAssets(path)
#
#	Compress a path to a assets.zip archive
#
#	@path	- The full path to add to the archive file
#
function(dk_compressAssets path)
	dk_debugFunc()
	
	dk_info("Compressing: ${path}")
	if(NOT EXISTS ${path})
		dk_fatal("The path ${path} does not exist")
	endif()
	execute_process(COMMAND ${CMAKE_COMMAND} -E tar "cfv" "${DK_Project_Dir}/assets.zip" --format=zip "." WORKING_DIRECTORY ${path}/)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
