#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

###############################################################################
# dk_DKBASH_DIR()
#
#
function(dk_DKBASH_DIR)
<<<<<<< HEAD
	dk_debugFunc()

	dk_validate(DKBRANCH_DIR "dk_DKBRANCH_DIR()")
		
		dk_set(DKBASH_DIR "${DKBRANCH_DIR}/DKBash")
		set(ENV{DKBASH_DIR} "${DKBRANCH_DIR}/DKBash")
		#dk_printVar(DKBASH_DIR)
			dk_set(DKBASH_FUNCTIONS_DIR "${DKBASH_DIR}/functions")
			set(ENV{DKBASH_FUNCTIONS_DIR} "${DKBASH_DIR}/functions")
			#dk_printVar(DKBASH_FUNCTIONS_DIR)
			dk_set(DKBASH_FUNCTIONS_DIR_ "${DKBASH_DIR}/functions/")
			set(ENV{DKBASH_FUNCTIONS_DIR_} "${DKBASH_DIR}/functions/")
			#dk_printVar(DKBASH_FUNCTIONS_DIR_)
=======
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGN)
		dk_set(ENV{DKBASH_DIR} "${ARGN}")

	###### GET ######
	else()
		dk_validate(ENV{DKBRANCH_DIR} "dk_DKBRANCH_DIR()")
		set(ENV{DKBASH_DIR} "$ENV{DKBRANCH_DIR}/DKBash")
	endif()

	dk_set(DKBASH_FUNCTIONS_DIR "$ENV{DKBASH_DIR}/functions")
	dk_set(DKBASH_FUNCTIONS_DIR_ "$ENV{DKBASH_DIR}/functions/")
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
	dk_debugFunc()
	
	dk_DKBASH_DIR()
	dk_printVar(DKBASH_DIR)
	dk_printVar(DKBASH_FUNCTIONS_DIR)
	dk_printVar(DKBASH_FUNCTIONS_DIR_)
=======
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting DKBASH_DIR . . .")
	dk_DKBASH_DIR()
	dk_printVar(ENV{DKBASH_DIR})

	dk_echo()
	dk_echo("Test Setting DKBASH_DIR . . .")
	dk_DKBASH_DIR("C:/DK/DKBash")
	dk_printVar(ENV{DKBASH_DIR})
>>>>>>> Development
endfunction()
