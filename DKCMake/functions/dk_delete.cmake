#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

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
	
	dk_getOption(NO_HALT)

	if(NOT EXISTS "${ARGV0}")
		dk_warning("${ARGV0} does not exist")
		dk_return()
	endif()
	
	### delete the path ###
	dk_debug("deleting ${ARGV0}")
	file(REMOVE_RECURSE "${ARGV0}")
	#execute_process(COMMAND -E rm "${ARGN}")
	
	### verify that the path was deleted ###
	#dk_sleep(1)	# give the path a 1 second to delete
	if(EXISTS "${ARGV0}")
		dk_fatal("failed to remove ${ARGV0}" ${NO_HALT})
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_fileWrite(removeMe.file "created file to test dk_delete")
	dk_delete("removeMe.file")
endfunction()