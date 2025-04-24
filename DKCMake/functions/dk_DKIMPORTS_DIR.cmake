#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_DKIMPORTS_DIR()
#
#
function(dk_DKIMPORTS_DIR)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_validate(DK3RDPARTY_DIR "dk_DK3RDPARTY_DIR()")
	
		dk_set(DKIMPORTS_DIR "${DK3RDPARTY_DIR}/_DKIMPORTS")
		set(ENV{DKIMPORTS_DIR} "${DK3RDPARTY_DIR}/_DKIMPORTS")
		#dk_printVar(DKIMPORTS_DIR)
=======
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGN)
		dk_set(ENV{DKIMPORTS_DIR} "${ARGN}")

	###### GET ######
	else()
		dk_validate(ENV{DK3RDPARTY_DIR} "dk_DK3RDPARTY_DIR()")
		dk_set(ENV{DKIMPORTS_DIR} "$ENV{DK3RDPARTY_DIR}/_DKIMPORTS")
	endif()
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_DKIMPORTS_DIR()
	dk_printVar(DKIMPORTS_DIR)
=======
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting DKIMPORTS_DIR . . .")
	dk_DKIMPORTS_DIR()
	dk_printVar(ENV{DKIMPORTS_DIR})

	dk_echo()
	dk_echo("Test Setting DKIMPORTS_DIR . . .")
	dk_DKIMPORTS_DIR("C:/DK/DKImports")
	dk_printVar(ENV{DKIMPORTS_DIR})
>>>>>>> Development
endfunction()
