#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DIGITALKNOB_DIR()
#
#
function(dk_DIGITALKNOB_DIR)
    dk_debugFunc()

    if(DEFINED DIGITALKNOB_DIR)
		return()
	endif()
            
	### DIGITALKNOB_DIR ###
	dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
	#if(NOT DEFINED DIGITALKNOB set "DIGITALKNOB=D i g i t a l K n o b")
    if(NOT DEFINED DIGITALKNOB)
		dk_set(DIGITALKNOB "digitalknob")
		set(ENV{DIGITALKNOB} "digitalknob")
	endif()
	dk_set(DIGITALKNOB_DIR "${DKHOME_DIR}/${DIGITALKNOB}")
	set(ENV{DIGITALKNOB_DIR} "${DKHOME_DIR}/${DIGITALKNOB}")
    if(NOT EXISTS "${DIGITALKNOB_DIR}")
		dk_makeDirectory("${DIGITALKNOB_DIR}")
	endif()
	
	### DKDOWNLOAD_DIR ###
	dk_set(DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download")
	set(ENV{DKDOWNLOAD_DIR} "${DIGITALKNOB_DIR}/download")
	if(NOT EXISTS "${DKDOWNLOAD_DIR}") 
		dk_makeDirectory("${DKDOWNLOAD_DIR}")
	endif()
	
#	### DKTOOLS_DIR ###
#	dk_set(DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools")
#	set(ENV{DKTOOLS_DIR} "${DIGITALKNOB_DIR}/DKTools")
#	if(NOT EXISTS "${DKTOOLS_DIR}") 
#		dk_makeDirectory("${DKTOOLS_DIR}")
#	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_DIGITALKNOB_DIR()
    dk_printVar(DIGITALKNOB_DIR)
endfunction()
