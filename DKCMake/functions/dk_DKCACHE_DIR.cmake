#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DKCACHE_DIR() <set_var>
#
#
function(dk_DKCACHE_DIR)
    dk_debugFunc(0 1)
	
	###### SET ######
	if(ARGN)
		dk_set(DKCACHE_DIR "${ARGN}")
		
	###### GET ######
	else()
		dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
		dk_set(DKCACHE_DIR "${DKHOME_DIR}/.dk")
	endif()
	if(NOT EXISTS "${DKCACHE_DIR}")
		dk_makeDirectory("${DKCACHE_DIR}")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKCACHE_DIR . . .")
	dk_DKCACHE_DIR()
	dk_printVar(DKCACHE_DIR)
	
	dk_echo()
	dk_echo("Test Setting DKCACHE_DIR . . .")
	dk_DKCACHE_DIR("C:/.dk")
	dk_printVar(DKCACHE_DIR)
endfunction()
