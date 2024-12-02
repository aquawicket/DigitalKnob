#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_gitCheckout(branch)
#
#
function(dk_gitCheckout)
	message("dk_gitCheckout(${ARGV+})")
	dk_debugFunc(1)
	
	dk_depend(git)
	
	execute_process(COMMAND "${GIT_EXE}" checkout ${ARGV0})
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_gitCheckout("Development")
endfunction()