#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

################################################################################
# dk_setTitle(string)
#
#
function(dk_setTitle)
    dk_debugFunc(0 99)
 
    execute_process(COMMAND cmd /c title "${ARGV}")
endfunction()











###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)

    dk_setTitle("DKTEST()")
endfunction()
