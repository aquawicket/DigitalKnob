#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_delete(path [NO_HALT])
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_delete(path) [NO_HALT]
>>>>>>> Development
#
#	Remove a file or directory
#
#	@path		- The full path to the file or direcotory to remove
#   NO_HALT     - if NO_HALT is specified in the parameters, dk_fatal() messages will not be displayed
#
<<<<<<< HEAD
function(dk_delete path)
	dk_debugFunc()
	
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
=======
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
>>>>>>> Development
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_fileWrite(removeMe.file "created file to test dk_delete")
	dk_delete(removeMe.file)
=======
	dk_debugFunc(0)
	
	dk_fileWrite(removeMe.file "created file to test dk_delete")
	dk_delete("removeMe.file")
>>>>>>> Development
endfunction()