#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

####################################################################
# dk_DIGITALKNOB_DIR()
#
#
function(dk_DIGITALKNOB_DIR)
	dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(DIGITALKNOB_DIR "${ARGV}")
		return()
	endif()

	### DIGITALKNOB_DIR ###
	dk_validate(DKHOME_DIR "dk_DKHOME_DIR()")
	dk_printVar(DKHOME_DIR)
	
	#if(NOT DEFINED DIGITALKNOB) 
	#	dk_set(DIGITALKNOB "D i g i t a l K n o b") 
	#endif()
	if(NOT DEFINED DIGITALKNOB)
		dk_set(DIGITALKNOB "digitalknob")
	endif()

	dk_set(DIGITALKNOB_DIR "${DKHOME_DIR}/${DIGITALKNOB}")
    if(NOT EXISTS "${DIGITALKNOB_DIR}")
		dk_mkdir("${DIGITALKNOB_DIR}")
	endif()
	
#	### DKDOWNLOAD_DIR ###
#	#dk_set(DKDOWNLOAD_DIR "${DIGITALKNOB_DIR}/download")
#	if(NOT EXISTS "${DKDOWNLOAD_DIR}") 
#		dk_mkdir("${DKDOWNLOAD_DIR}")
#	endif()
	
#	### DKTOOLS_DIR ###
#	dk_set(DKTOOLS_DIR "${DIGITALKNOB_DIR}/DKTools")
#	if(NOT EXISTS "${DKTOOLS_DIR}") 
#		dk_mkdir("${DKTOOLS_DIR}")
#	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
   
	dk_DIGITALKNOB_DIR()
    dk_printVar(DIGITALKNOB_DIR)
endfunction()
