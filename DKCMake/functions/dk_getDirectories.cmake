include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()

################################################################################
# dk_getDirectories(path rtn_var)
#
#   reference: https://stackoverflow.com/a/138581
#
function(dk_getDirectories path rtn_var)
    dk_debugFunc("\${ARGV}")
	#dk_verbose("dk_getDirectories(${path}, ${rtn_var})")
    
	#file(GLOB_RECURSE children LIST_DIRECTORIES true ${path}/*)
	file(GLOB children LIST_DIRECTORIES true ${path}/*)
	foreach(child ${children})
        if(IS_DIRECTORY ${child})
			dk_echo(${child})
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
    dk_debugFunc("\${ARGV}")
 
    set(myPath "C:/Windows")
    dk_getDirectories("${myPath}" directories)
    dk_printVar(directories)
endfunction()
    