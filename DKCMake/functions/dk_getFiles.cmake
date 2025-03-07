#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_getFiles(path rtn_var)
#
#
function(dk_getFiles path rtn_var)
    dk_debugFunc()
	#dk_verbose("dk_getDirectories(${path}, ${rtn_var})")
    
	#file(GLOB_RECURSE children LIST_DIRECTORIES true ${path}/*)
	file(GLOB children LIST_DIRECTORIES true ${path}/*)
	foreach(child ${children})
        if(NOT IS_DIRECTORY ${child})
			dk_echo(${child})
            list(APPEND _files_ ${child})
        endif()
    endforeach()

    # Return the array to the calling scope
	set(${rtn_var} ${_files_} PARENT_SCOPE)
	
# DEBUG
#	dk_printVar(_files_)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
    set(myPath "C:/Windows")
    dk_getFiles("${myPath}" files)
    dk_printVar(files)
endfunction()
    