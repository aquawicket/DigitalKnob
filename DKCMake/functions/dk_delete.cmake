include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_delete(path [NO_HALT])
#
#	Remove a file or directory
#
#	@path		- The full path to the file or direcotory to remove
#   NO_HALT     - if NO_HALT is specified in the parameters, dk_fatal() messages will not be displayed
#
function(dk_delete path)
	dk_debugFunc(${ARGV})
	
	dk_getOption(NO_HALT ${ARGV})

	if(NOT EXISTS ${path})
		if(NOT NO_HALT)
			dk_warning("${path} does not exist")
		endif()
		return()
	endif()
	file(REMOVE_RECURSE ${path})
	#execute_process(COMMAND -E rm ${path})
	dk_sleep(1)	# give the path a second to delete
	if(EXISTS ${path})
		if(NOT NO_HALT)
			dk_fatal("failed to remove ${path}")
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_fileWrite(removeMe.file "created file to test dk_delete")
	dk_delete(removeMe.file)
endfunction()