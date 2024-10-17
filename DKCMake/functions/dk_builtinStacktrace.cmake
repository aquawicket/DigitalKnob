#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


##################################################################################
# dk_builtinStacktrace()
#
#
function(dk_builtinStacktrace)
    dk_debugFunc()

	message(WARNING)
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc()
	
	dk_builtinStacktrace()
endfunction()