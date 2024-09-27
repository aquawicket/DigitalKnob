#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
#include_guard()


##################################################################################
# dk_builtinStacktrace()
#
#
function(dk_builtinStacktrace)
    dk_debugFunc("\${ARGV}")

	message(WARNING)
endfunction()



###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_builtinStacktrace()
endfunction()