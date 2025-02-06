#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

###############################################################################
# dk_DKPLUGINS_DIR()
#
#
function(dk_DKPLUGINS_DIR)
	dk_debugFunc(0 1)
	
	###### SET ######
	if(ARGN)
		dk_set(DKPLUGINS_DIR "${ARGN}")
		
	###### GET ######
	else()
		dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		dk_set(DKPLUGINS_DIR "${DKBRANCH_DIR}/DKCpp/DKPlugins")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DKPLUGINS_DIR . . .")
	dk_DKPLUGINS_DIR()
	dk_printVar(DKPLUGINS_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKPLUGINS_DIR . . .")
	dk_DKPLUGINS_DIR("C:/DK/DKPlugins")
	dk_printVar(DKPLUGINS_DIR)
endfunction()
