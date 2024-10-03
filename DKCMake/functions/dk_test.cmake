#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_test()
#
#
function(dk_test)
	dk_debugFunc("\${ARGV}")

	dk_echo("DKSCRIPT_PATH = ${DKSCRIPT_PATH}")
    dk_echo("DKSCRIPT_DIR  = ${DKSCRIPT_DIR}")
    dk_echo("DKSCRIPT_NAME = ${DKSCRIPT_NAME}")
    dk_echo("DKSCRIPT_EXT  = ${DKSCRIPT_EXT}")
    dk_echo("__FILE__      = $(__FILE__)")
    dk_echo("__LINE__      = $(__LINE__)")
    dk_echo("__FUNCTION__  = $(__FUNCTION__)")
    dk_echo("__ARGC__      = $(__ARGC__)")
#   dk_echo("__ARGV__     = $(__ARGV__)")
    dk_echo("__CALLER__    = $(__CALLER__)")
	

endfunction()







###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_test(3)
endfunction()