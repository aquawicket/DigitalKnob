#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

####################################################################
# dk_DKCACHE_DIR() <set_var>
#
#
function(dk_DKCACHE_DIR)
    dk_debugFunc(0 1)
	
	###### SET ######
	if(ARGV)
		set(ENV{DKCACHE_DIR} "${ARGV}")
		
	###### GET ######
	else()
		dk_validate(ENV{DKHOME_DIR} "dk_DKHOME_DIR()")
		set(ENV{DKCACHE_DIR} "$ENV{DKHOME_DIR}/.dk")
	endif()
	if(NOT EXISTS "$ENV{DKCACHE_DIR}")
		dk_makeDirectory("$ENV{DKCACHE_DIR}")
	endif()
	dk_assertPath(ENV{DKCACHE_DIR})
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKCACHE_DIR . . .")
	dk_DKCACHE_DIR()
	dk_printVar(ENV{DKCACHE_DIR})
	
	dk_echo()
	dk_echo("Test Setting DKCACHE_DIR . . .")
	dk_DKCACHE_DIR("C:/.dk")
	dk_printVar(ENV{DKCACHE_DIR})
endfunction()
