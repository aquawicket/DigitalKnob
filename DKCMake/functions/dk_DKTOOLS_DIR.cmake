#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DKTOOLS_DIR()
#
#
function(dk_DKTOOLS_DIR)
    dk_debugFunc()

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
	
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
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
endfunction()
