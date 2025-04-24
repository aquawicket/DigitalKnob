#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

####################################################################
# dk_DKTOOLS_DIR()
#
#
function(dk_DKTOOLS_DIR)
<<<<<<< HEAD
    dk_debugFunc(0 1)

	if(ARGN) ############ SET ############
		dk_set(DKTOOLS_DIR "${ARGN}")
		set(ENV{DKTOOLS_DIR} "${ARGN}")
		
	else() ############ GET ############
		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
		dk_set(DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools")
		set(ENV{DKTOOLS_DIR} "${DIGITALKNOB_DIR}/DKTools")
		if(NOT EXISTS "${DKTOOLS_DIR}") 
			dk_makeDirectory("${DKTOOLS_DIR}")
		endif()
	endif()
	
=======
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGN)
		dk_set(ENV{DKTOOLS_DIR} "${ARGN}")

	###### GET ######
	else()
		dk_validate(ENV{DIGITALKNOB_DIR} "dk_DIGITALKNOB_DIR()")
		dk_set(ENV{DKTOOLS_DIR} "$ENV{DIGITALKNOB_DIR}/DKTools")
	endif()

	if(NOT EXISTS "$ENV{DKTOOLS_DIR}") 
		dk_mkdir("$ENV{DKTOOLS_DIR}")
	endif()
>>>>>>> Development
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
<<<<<<< HEAD
    dk_debugFunc(0)
   
	###### GET ######
	dk_DKTOOLS_DIR()
    dk_printVar(DKTOOLS_DIR)
	
	###### SET ######
	dk_DKTOOLS_DIR("C:/Dummy/DKTools")
	dk_printVar(DKTOOLS_DIR)
	
	###### GET ######
	dk_DKTOOLS_DIR()
    dk_printVar(DKTOOLS_DIR)
	
	###### SET ######
	dk_DKTOOLS_DIR("C:/dk2/DKTools")
	dk_printVar(DKTOOLS_DIR)
=======
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting DKTOOLS_DIR . . .")
	dk_DKTOOLS_DIR()
	dk_printVar(ENV{DKTOOLS_DIR})

	dk_echo()
	dk_echo("Test Setting DKTOOLS_DIR . . .")
	dk_DKTOOLS_DIR("C:/DKTools")
	dk_printVar(ENV{DKTOOLS_DIR})
>>>>>>> Development
endfunction()
