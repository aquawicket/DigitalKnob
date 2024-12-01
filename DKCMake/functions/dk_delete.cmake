#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_delete(path) [NO_HALT]
#
#	Remove a file or directory
#
#	@path		- The full path to the file or direcotory to remove
#   NO_HALT     - if NO_HALT is specified in the parameters, dk_fatal() messages will not be displayed
#
function(dk_delete)
	dk_debugFunc(1 2)
	
	dk_getOption(NO_HALT ${ARGV} REMOVE)

	if(NOT EXISTS "${ARGN}")
		dk_warning("${ARGN} does not exist")
		return()
	endif()
	
	message("deleting ${ARGN}")
	file(REMOVE_RECURSE "${ARGN}")
	#execute_process(COMMAND -E rm "${ARGN}")
	dk_sleep(1)	# give the path a 1 second to delete
	if(EXISTS "${ARGN}")
		if(NOT NO_HALT)
			dk_error("failed to remove ${ARGN}")
		endif()
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_fileWrite(removeMe.file "created file to test dk_delete")
	dk_delete("removeMe.file")
endfunction()