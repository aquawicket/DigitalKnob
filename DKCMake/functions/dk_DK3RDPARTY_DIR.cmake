#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
function(dk_DK3RDPARTY_DIR)
	dk_debugFunc(0 1)
	
	if(ARGN0)
		set(ENV{DK3RDPARTY_DIR} "${ARGN0}")
	else()
		dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
		set(ENV{DK3RDPARTY_DIR} "$ENV{DKBRANCH_DIR}/3rdParty")
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DK3RDPARTY_DIR . . .")
	dk_DK3RDPARTY_DIR()
	dk_printVar(ENV{DK3RDPARTY_DIR})
	
	dk_echo()
	dk_echo("Test Setting DK3RDPARTY_DIR . . .")
	dk_DK3RDPARTY_DIR("C:/.dk")
	dk_printVar(ENV{DK3RDPARTY_DIR})
endfunction()
