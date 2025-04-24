#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_DK3RDPARTY_DIR()
#
#
function(dk_DK3RDPARTY_DIR)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
	
		dk_set(DK3RDPARTY_DIR "${DKBRANCH_DIR}/3rdParty")
		set(ENV{DK3RDPARTY_DIR} "${DKBRANCH_DIR}/3rdParty")
		#dk_printVar(DK3RDPARTY_DIR)
=======
	dk_debugFunc(0 1)
	
	if(ARGN0)
		set(ENV{DK3RDPARTY_DIR} "${ARGN0}")
	else()
		dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
		set(ENV{DK3RDPARTY_DIR} "$ENV{DKBRANCH_DIR}/3rdParty")
	endif()
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_DK3RDPARTY_DIR()
	dk_printVar(DKBRANCH_DIR)
=======
	dk_debugFunc(0)
	
	dk_echo()
	dk_echo("Test Getting DK3RDPARTY_DIR . . .")
	dk_DK3RDPARTY_DIR()
	dk_printVar(ENV{DK3RDPARTY_DIR})
	
	dk_echo()
	dk_echo("Test Setting DK3RDPARTY_DIR . . .")
	dk_DK3RDPARTY_DIR("C:/.dk")
	dk_printVar(ENV{DK3RDPARTY_DIR})
>>>>>>> Development
endfunction()
