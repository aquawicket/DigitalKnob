#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

####################################################################
# dk_DKCACHE_DIR()
#
#
function(dk_DKDESKTOP_DIR)
    dk_debugFunc(0 1)

	###### SET ######
	if(ARGN)
		dk_set(DKDESKTOP_DIR "${ARGN}")
		
	###### GET ######
	else()
		dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
		dk_set(DKDESKTOP_DIR "${DKHOME_DIR}/Desktop")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKDESKTOP_DIR . . .")
	dk_DKDESKTOP_DIR()
	dk_printVar(DKDESKTOP_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKDESKTOP_DIR . . .")
	dk_DKDESKTOP_DIR("C:/Desktop")
	dk_printVar(DKDESKTOP_DIR)
endfunction()
