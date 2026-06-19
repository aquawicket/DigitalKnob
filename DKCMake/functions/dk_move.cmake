#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
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
	dk_debugFunc()
	
	dk_getParameter(OVERWRITE)
	dk_getParameter(NO_HALT)
	
	#dk_debug("Moving ${from} to ${to}")
	if(NOT EXISTS ${from})
		if(NOT NO_HALT)
			dk_fatal("from:${from} NOT FOUND")
		endif()
		dk_return()
	endif()
	if(EXISTS ${to})
		if(NOT OVERWRITE)
			dk_fatal("Cannot move file. Destiantion exists and not set to OVERWRITE")
		endif()
		dk_delete(${to})
	endif()
	
	# the base directory of the ${to} path must exist.    
	dk_dirname(${to} PARENT_DIR)
	dk_mkdir(${PARENT_DIR})
	
	file(RENAME ${from} ${to})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
    
	dk_validate(DKDOWNLOAD_DIR "dk_DKDOWNLOAD_DIR()")
    dk_fileWrite("${DKDOWNLOAD_DIR}/moveMe.file" "dk_move test")
    dk_move("${DKDOWNLOAD_DIR}/moveMe.file" "${DIGITALKNOB_DIR}/iWasMoved.txt" OVERWRITE)
    
    dk_fileWrite(moveMe.file "dk_move test")
    dk_move(moveMe.file iWasMoved.txt OVERWRITE)
    
    dk_mkdir("${DKDOWNLOAD_DIR}/moveMe")
#endfunction()

    dk_move("${DKDOWNLOAD_DIR}/moveMe" "${DIGITALKNOB_DIR}/iWasMoved" OVERWRITE)
    
    dk_mkdir(moveMe)
    dk_move(moveMe iWasMoved OVERWRITE)
endfunction()
