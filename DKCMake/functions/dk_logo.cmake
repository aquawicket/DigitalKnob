include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
##include_guard()

################################################################################
# dk_logo()
#
function(dk_logo)
	dk_debugFunc(${ARGV})
	
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
	dk_debugFunc(${ARGV})
	
	dk_logo()
endfunction()
