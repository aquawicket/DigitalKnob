#!/usr/bin/cmake -P
<<<<<<< HEAD
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()
=======
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
>>>>>>> Development

####################################################################
# dk_DIGITALKNOB_DIR()
#
#
function(dk_DIGITALKNOB_DIR)
<<<<<<< HEAD
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
=======
	dk_debugFunc()

# 	if(DEFINED ENV{DIGITALKNOB_DIR})
#		return()
#	endif()

	###### SET ######
	if(ARGN0)
		set(ENV{DIGITALKNOB_DIR} "${ARGN0}")
		return()
	endif()

	### DIGITALKNOB_DIR ###
	dk_validate(ENV{DKHOME_DIR} "dk_DKHOME_DIR()")
	dk_printVar(ENV{DKHOME_DIR})
	
	#if(NOT DEFINED ENV{DIGITALKNOB} set "DIGITALKNOB=D i g i t a l K n o b")
	if(NOT DEFINED ENV{DIGITALKNOB})
		#dk_set(DIGITALKNOB "digitalknob")
		set(ENV{DIGITALKNOB} "digitalknob")
	endif()
	#dk_set(DIGITALKNOB_DIR "$ENV{DKHOME_DIR}/$ENV{DIGITALKNOB}")
	set(ENV{DIGITALKNOB_DIR} "$ENV{DKHOME_DIR}/$ENV{DIGITALKNOB}")
    if(NOT EXISTS "$ENV{DIGITALKNOB_DIR}")
		dk_mkdir("$ENV{DIGITALKNOB_DIR}")
	endif()
	
#	### DKDOWNLOAD_DIR ###
#	#dk_set(ENV{DKDOWNLOAD_DIR} "$ENV{DIGITALKNOB_DIR}/download")
#	if(NOT EXISTS "$ENV{DKDOWNLOAD_DIR}") 
#		dk_mkdir("$ENV{DKDOWNLOAD_DIR}")
#	endif()
	
#	### DKTOOLS_DIR ###
#	dk_set(ENV{DKTOOLS_DIR} "$ENV{DIGITALKNOB_DIR}/DKTools")
#	if(NOT EXISTS "$ENV{DKTOOLS_DIR}") 
#		dk_mkdir("$ENV{DKTOOLS_DIR}")
>>>>>>> Development
#	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_DIGITALKNOB_DIR()
<<<<<<< HEAD
    dk_printVar(DIGITALKNOB_DIR)
=======
    dk_printVar(ENV{DIGITALKNOB_DIR})
>>>>>>> Development
endfunction()
