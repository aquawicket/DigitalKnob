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

################################################################################
# dk_getFiles(<path> <ret:optional>)
#
#
function(dk_getFiles)
    dk_debugFunc(1 2)
    
	set(path ${ARGV0})
	set(ret ${ARGV1})
	#file(GLOB_RECURSE children LIST_DIRECTORIES true ${path}/*)
	file(GLOB children LIST_DIRECTORIES true ${path}/*)
	foreach(child ${children})
        if(NOT IS_DIRECTORY ${child})
			dk_echo(${child})
            list(APPEND dk_getFiles ${child})
        endif()
    endforeach()

    # Return the array to the calling scope
	set(dk_getFiles ${dk_getFiles} PARENT_SCOPE)
	if(ARGV1)
		set(${ARGV1} ${dk_getFiles} PARENT_SCOPE)
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
    set(myPath "C:/Windows")
    dk_getFiles("${myPath}")
    dk_printVar(dk_getFiles)
	
	set(myPath "C:/Windows/System32")
	dk_getFiles("${myPath}" files)
    dk_printVar(dk_getFiles)
	dk_printVar(files)
endfunction()
    