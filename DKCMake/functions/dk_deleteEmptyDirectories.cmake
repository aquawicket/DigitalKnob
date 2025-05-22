#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

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
	if(Windows_Host)
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
	dk_debugFunc(0)
	
	dk_todo()
endfunction()
