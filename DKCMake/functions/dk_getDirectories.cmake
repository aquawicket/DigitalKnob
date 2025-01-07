#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

################################################################################
# dk_getDirectories(path rtn_var)
#
#   reference: https://stackoverflow.com/a/138581
#
function(dk_getDirectories path rtn_var)
    dk_debugFunc()
	#dk_verbose("dk_getDirectories(${path}, ${rtn_var})")
    
	dk_getOption(RECURSIVE)
	
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
 
	dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
    dk_getDirectories("${DIGITALKNOB_DIR}" directories)# RECURSIVE)
    dk_printVar(directories)
endfunction()
    