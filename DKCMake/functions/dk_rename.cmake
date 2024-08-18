include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_rename(from to) OVERWRITE NO_HALT
#
#	Rename file or directory or move a file or directory to another location
#
#	@from		- The source path to copy
#	@to			- The destination path to copy to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#   NO_HALT     - if any of the parameters equals NO_HALT, dk_error() messages will not be displayed
#
function(dk_rename from to) # FLAGS: OVERWRITE, NO_HALT
	dk_debugFunc(${ARGV})
	
	dk_getOption(OVERWRITE ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	
	dk_info("Renameing ${from} to ${to}")
	if(NOT EXISTS ${from})
		if(NOT NO_HALT)
			dk_error("from:${from} not found")
		endif()
		return()
	endif()
	if(EXISTS ${to})
		if(NOT OVERWRITE)
			dk_error("Cannot rename file. Destiantion exists and not set to OVERWRITE")
		endif()
		dk_delete(${to})
	endif()
	
	# the base directory of the ${to} path must exist.    
	dk_dirname(${to} PARENT_DIR)
	dk_makeDirectory(${PARENT_DIR})
	
	file(RENAME ${from} ${to})
endfunction()
dk_createOsMacros("dk_rename")




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(${ARGV})
	
	dk_todo()
endfunction()
