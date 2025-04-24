#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

################################################################################
# dk_getDirectories(path rtn_var)
#
#   reference: https://stackoverflow.com/a/138581
#
function(dk_getDirectories path rtn_var)
    dk_debugFunc()
	#dk_verbose("dk_getDirectories(${path}, ${rtn_var})")
    
<<<<<<< HEAD
	dk_getOption(RECURSIVE ${ARGV})
=======
	dk_getOption(RECURSIVE)
>>>>>>> Development
	
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
	
# DEBUG
#	dk_printVar(_directories_)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
<<<<<<< HEAD
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
    dk_getDirectories("${DIGITALKNOB_DIR}" directories)# RECURSIVE)
=======
	dk_validate(ENV{DIGITALKNOB_DIR} "dk_DIGITALKNOB_DIR()")
    dk_getDirectories("$ENV{DIGITALKNOB_DIR}" directories)# RECURSIVE)
>>>>>>> Development
    dk_printVar(directories)
endfunction()
    