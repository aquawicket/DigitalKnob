#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_getFiles(path rtn_var)
#
#
function(dk_getFiles path rtn_var)
    dk_debugFunc()
	#dk_verbose("dk_getDirectories(${path}, ${rtn_var})")
    
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

################################################################################
# dk_getFiles(<path> <ret:optional>)
#
#
function(dk_getFiles)
    dk_debugFunc(1 2)
    
	set(path ${ARGV0})
	set(ret ${ARGV1})
>>>>>>> Development
	#file(GLOB_RECURSE children LIST_DIRECTORIES true ${path}/*)
	file(GLOB children LIST_DIRECTORIES true ${path}/*)
	foreach(child ${children})
        if(NOT IS_DIRECTORY ${child})
			dk_echo(${child})
<<<<<<< HEAD
            list(APPEND _files_ ${child})
=======
            list(APPEND dk_getFiles ${child})
>>>>>>> Development
        endif()
    endforeach()

    # Return the array to the calling scope
<<<<<<< HEAD
	set(${rtn_var} ${_files_} PARENT_SCOPE)
	
# DEBUG
#	dk_printVar(_files_)
=======
	set(dk_getFiles ${dk_getFiles} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_getFiles} PARENT_SCOPE)
	endif()
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
    set(myPath "C:/Windows")
<<<<<<< HEAD
    dk_getFiles("${myPath}" files)
    dk_printVar(files)
=======
    dk_getFiles("${myPath}")
    dk_printVar(dk_getFiles)
	
	set(myPath "C:/Windows/System32")
	dk_getFiles("${myPath}" files)
    dk_printVar(dk_getFiles)
	dk_printVar(files)
>>>>>>> Development
endfunction()
    