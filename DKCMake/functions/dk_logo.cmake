#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
##include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
#include_guard()
>>>>>>> Development

################################################################################
# dk_logo()
#
function(dk_logo)
	dk_debugFunc()
	
	dk_echo("${lblue}   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______        ")
	dk_echo("${lblue}   |     \\   |   |  ____   |      |    |_____| |      |____/  | \\  | |     | |_____]     ")
	dk_echo("${blue}   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \\_ |  \\_| |_____| |_____]      ")
	dk_echo("${yellow}                                                                     __      __           ")
    dk_echo("${yellow}                                                                    |  \\|_//   _  _ |  _ ")
    dk_echo("${yellow}                                                                    |__/| \\\\__|||(_||((- ")
	dk_echo("${clr}")
                                                                        
endfunction()
dk_logo()



function(DKTEST) ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###
	dk_debugFunc()
	
	dk_logo()
endfunction()
