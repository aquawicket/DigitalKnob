include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
include_guard()

###############################################################################
# dk_remove(path [NOERROR])
#
#	Remove a file or directory
#
#	@path		- The full path to the file or direcotory to remove
#   NOERROR     - if NOERROR is specified in the parameters, dk_error() messages will not be displayed
#
function(dk_remove path)
	dk_debugFunc(${ARGV})
	
	dk_getOption(NOERROR ${ARGV})

	if(NOT EXISTS ${path})
		if(NOT NOERROR)
			dk_warning("${path} does not exist")
		endif()
		return()
	endif()
	file(REMOVE_RECURSE ${path})
	#execute_process(COMMAND -E rm ${path})
	dk_sleep(1)	# give the path a second to delete
	if(EXISTS ${path})
		if(NOT NOERROR)
			dk_error("failed to remove ${path}")
		endif()
	endif()
endfunction()





function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction(DKTEST)