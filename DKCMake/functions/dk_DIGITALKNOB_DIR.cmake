#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

####################################################################
# dk_DIGITALKNOB_DIR()
#
#
function(dk_DIGITALKNOB_DIR)
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
		dk_makeDirectory("$ENV{DIGITALKNOB_DIR}")
	endif()
	
#	### DKDOWNLOAD_DIR ###
#	#dk_set(ENV{DKDOWNLOAD_DIR} "$ENV{DIGITALKNOB_DIR}/download")
#	if(NOT EXISTS "$ENV{DKDOWNLOAD_DIR}") 
#		dk_makeDirectory("$ENV{DKDOWNLOAD_DIR}")
#	endif()
	
#	### DKTOOLS_DIR ###
#	dk_set(ENV{DKTOOLS_DIR} "$ENV{DIGITALKNOB_DIR}/DKTools")
#	if(NOT EXISTS "$ENV{DKTOOLS_DIR}") 
#		dk_makeDirectory("$ENV{DKTOOLS_DIR}")
#	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_DIGITALKNOB_DIR()
    dk_printVar(ENV{DIGITALKNOB_DIR})
endfunction()
