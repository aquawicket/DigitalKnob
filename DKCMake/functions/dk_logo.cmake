#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
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
