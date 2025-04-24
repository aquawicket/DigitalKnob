#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_deleteEmptyDirectories(path)
#
#	Delete all empty directories within a path
#
#	@path	- The path to remove all empty directories from
#
function(dk_deleteEmptyDirectories path)
	dk_debugFunc()
	
	if(NOT EXISTS ${path})
		dk_warning("dk_deleteEmptyDirectories(): path:${path} does not exist")
		dk_return()
	endif()
	if(WIN_HOST)
		#execute_process(COMMAND for /f "delims=" %d in ('dir /s /b /ad ^| sort /r') do rd "%d" WORKING_DIRECTORY ${path})
		# https://stackoverflow.com/a/30138960/688352
		
		### ROBOCOPY ###
		# /S   :: copy Subdirectories, but not empty ones.
	    # /NS  :: No Size - don't log file sizes.
        # /NC  :: No Class - don't log file classes.
        # /NFL :: No File List - don't log file names.
        # /NDL :: No Directory List - don't log directory names.
		# /NJH :: No Job Header.
        # /NJS :: No Job Summary.
		# /NP  :: No Progress - don't display percentage copied.
		execute_process(COMMAND ROBOCOPY ${path} ${path} /NS /NC /NFL /NDL /NJH /NJS /NP /S /MOVE WORKING_DIRECTORY ${path})
	else()
	
		execute_process(COMMAND find ${path} -empty -type d -delete WORKING_DIRECTORY ${path})
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
=======
	dk_debugFunc(0)
>>>>>>> Development
	
	dk_todo()
endfunction()
