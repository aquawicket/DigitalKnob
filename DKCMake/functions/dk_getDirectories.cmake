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
# dk_getDirectories(path rtn_var)
#
#   reference: https://stackoverflow.com/a/138581
#
function(dk_getDirectories path rtn_var)
    dk_debugFunc()
	#dk_verbose("dk_getDirectories(${path}, ${rtn_var})")
    
	dk_getParameter(RECURSIVE)
	
	if(RECURSIVE)
		file(GLOB_RECURSE children LIST_DIRECTORIES true ${path}/*)
	else()
		file(GLOB children LIST_DIRECTORIES true ${path}/*)
	endif()
	foreach(child ${children})
        if(IS_DIRECTORY ${child})
			#dk_echo(${child})
            list(APPEND _directories_ ${child})
        endif()
    endforeach()

    # Return the array to the calling scope
	set(${rtn_var} ${_directories_} PARENT_SCOPE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
	dk_validate(ENV{DIGITALKNOB_DIR} "dk_DIGITALKNOB_DIR()")
    dk_getDirectories("$ENV{DIGITALKNOB_DIR}" directories)# RECURSIVE)
    dk_printVar(directories)
endfunction()
    