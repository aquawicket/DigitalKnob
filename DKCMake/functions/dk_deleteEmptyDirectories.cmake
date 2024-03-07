include_guard()

###############################################################################
# dk_deleteEmptyDirectories(path)
#
#	Delete all empty directories within a path
#
#	@path	- The path to remove all empty directories from
#
function(dk_deleteEmptyDirectories path)
	DKDEBUGFUNC(${ARGV})
	if(NOT EXISTS ${path})
		dk_error("path:${path} does not exist")
		dk_return()
	endif()
	if(WIN_HOST)
		#execute_process(COMMAND for /f "delims=" %d in ('dir /s /b /ad ^| sort /r') do rd "%d" WORKING_DIRECTORY ${path})
		# https://stackoverflow.com/a/30138960/688352
		execute_process(COMMAND ROBOCOPY ${path} ${path} /S /MOVE WORKING_DIRECTORY ${path})
	else()
		execute_process(COMMAND find ${path} -empty -type d -delete WORKING_DIRECTORY ${path})
	endif()
endfunction()
