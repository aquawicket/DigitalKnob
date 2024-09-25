include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

###############################################################################
# dk_move(from to) OVERWRITE NO_HALT
#
#	Move file or directory to another location
#
#	@from		- The source path to mov
#	@to			- The destination path to move to
#	OVERWRITE	- if any of the parameters equals OVERWRITE, overwritting existing files is enabled
#   NO_HALT     - if any of the parameters equals NO_HALT, dk_fatal() messages will not be displayed
#
function(dk_move from to) # FLAGS: OVERWRITE, NO_HALT
	dk_debugFunc("\${ARGV}")
	
	dk_getOption(OVERWRITE ${ARGV})
	dk_getOption(NO_HALT ${ARGV})
	
	dk_info("Moving ${from} to ${to}")
	if(NOT EXISTS ${from})
		if(NOT NO_HALT)
			dk_fatal("from:${from} not found")
		endif()
		return()
	endif()
	if(EXISTS ${to})
		if(NOT OVERWRITE)
			dk_fatal("Cannot move file. Destiantion exists and not set to OVERWRITE")
		endif()
		dk_delete(${to})
	endif()
	
	# the base directory of the ${to} path must exist.    
	dk_dirname(${to} PARENT_DIR)
	dk_makeDirectory(${PARENT_DIR})
	
	file(RENAME ${from} ${to})
endfunction()
#dk_createOsMacros("dk_move")




###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_validate(DIGITALKNOB_DIR "dk_setDIGITALKNOB_DIR()")
    
	dk_validate(DKDOWNLOAD_DIR "dk_setDKDOWNLOAD_DIR()")
    dk_fileWrite("${DKDOWNLOAD_DIR}/moveMe.file" "dk_move test")
    dk_move("${DKDOWNLOAD_DIR}/moveMe.file" "${DIGITALKNOB_DIR}/iWasMoved.txt" OVERWRITE)
    
    dk_fileWrite(moveMe.file "dk_move test")
    dk_move(moveMe.file iWasMoved.txt OVERWRITE)
    
    dk_makeDirectory("${DKDOWNLOAD_DIR}/moveMe")
#endfunction()

    dk_move("${DKDOWNLOAD_DIR}/moveMe" "${DIGITALKNOB_DIR}/iWasMoved" OVERWRITE)
    
    dk_makeDirectory(moveMe)
    dk_move(moveMe iWasMoved OVERWRITE)
endfunction()
