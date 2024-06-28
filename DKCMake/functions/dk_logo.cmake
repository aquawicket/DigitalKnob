include(${DKCMAKE_FUNCTIONS_DIR}/DK.cmake)
##include_guard()

################################################################################
# dk_logo()
#
function(dk_logo)
	dk_debugFunc(${ARGV})
	
	
	message("${lblue}   ______  _____ _______ ______ ______ ______        _     __ _   _   _____  ______        ")
	message("${lblue}   |     \\   |   |  ____   |      |    |_____| |      |____/  | \\  | |     | |_____]     ")
	message("${blue}   |_____/ __|__ |_____| __|__    |    |     | |_____ |    \\_ |  \\_| |_____| |_____]      ")
	message("${yellow}                                                                     __      __           ")
    message("${yellow}                                                                    |  \\|_//   _  _ |  _ ")
    message("${yellow}                                                                    |__/| \\\\__|||(_||((- ")
	message("${clr}")
                                                                        
endfunction()




function(DKTEST) ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	dk_debugFunc(${ARGV})
	
	dk_logo()
endfunction()
