#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_rename(from to) OVERWRITE NO_HALT
#
#	Rename file or directory or move a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#   NO_HALT     - if any of the parameters equals NO_HALT, dk_fatal() messages will not be displayed
#
function(dk_rename from to) # FLAGS: OVERWRITE, NO_HALT
	dk_debugFunc()
	
	dk_getOption(OVERWRITE)
	dk_getOption(NO_HALT)
	
	dk_debug("Renameing ${from} to ${to}")
	if(NOT EXISTS ${from})
		if(NOT NO_HALT)
			dk_fatal("from:${from} not found")
		endif()
		dk_return()
	endif()
	if(EXISTS ${to})
		if(NOT OVERWRITE)
			dk_fatal("Cannot rename file. Destiantion exists and not set to OVERWRITE")
		endif()
		dk_delete(${to})
	endif()
	
	# the base directory of the ${to} path must exist.    
	dk_dirname(${to} PARENT_DIR)
	dk_makeDirectory(${PARENT_DIR})
	
	file(RENAME ${from} ${to})
endfunction()




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_rename(todo)
endfunction()
