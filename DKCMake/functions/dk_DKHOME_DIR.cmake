#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DKHOME_DIR()
#
#
function(dk_DKHOME_DIR)
    dk_debugFunc("\${ARGV}")

    if(DEFINED DKHOME_DIR)
		return()
	endif()
    
    if(NOT DEFINED ENV{HOMEDRIVE})
		dk_error("HOMEDRIVE is invalid")
	endif()
	
    if(NOT DEFINED ENV{HOMEPATH})
		dk_error("HOMEPATH is invalid")
	endif()
	
	### DKHOME_DIR ###
    dk_set(DKHOME_DIR "$ENV{HOMEDRIVE}$ENV{HOMEPATH}")
	dk_replaceAll("${DKHOME_DIR}" "\\" "/" DKHOME_DIR)
	dk_set(DKHOME_DIR "${DKHOME_DIR}")
	set(ENV{DKHOME_DIR} "${DKHOME_DIR}")
    if(NOT EXISTS "${DKHOME_DIR}")
		dk_error("DKHOME_DIR:${DKHOME_DIR} does not exist")
	endif()
	
	### DKCACHE_DIR ###
	dk_set(DKCACHE_DIR "${DKHOME_DIR}/.dk")
	set(ENV{DKCACHE_DIR} "${DKHOME_DIR}/.dk")
	if(NOT EXISTS "${DKCACHE_DIR}")
		dk_makeDirectory("${DKCACHE_DIR}")
	endif()
	
	### DKDESKTOP_DIR ### 
	dk_set(DKDESKTOP_DIR "${DKHOME_DIR}/Desktop")
	set(ENV{DKDESKTOP_DIR} "${DKHOME_DIR}/Desktop")
	if(NOT EXISTS "${DKDESKTOP_DIR}") 
		dk_makeDirectory("${DKDESKTOP_DIR}")
	endif()
	
#	### DKTEMP_DIR ###
#	if(NOT EXISTS "${DKTEMP_DIR}")
#		dk_set(DKTEMP_DIR "$ENV{TMP}")
#	endif()
#	if(NOT EXISTS "${DKTEMP_DIR}")     
#		dk_set(DKTEMP_DIR "$ENV{TMPDIR}")
#	endif()
#	if(NOT EXISTS "${DKTEMP_DIR}")     
#		dk_set(DKTEMP_DIR "$ENV{TMP_DIR}")
#	endif()
#	if(NOT EXISTS "${DKTEMP_DIR}")
#		dk_validate(DIGITALKNOB_DIR "dk_DIGITALKNOB_DIR()")
#		dk_set(DKTEMP_DIR "${DIGITALKNOB_DIR}")
#	endif()
#	
#	if(EXISTS "${DKTEMP_DIR}")
#		dk_set(DKTEMP_DIR "${DKTEMP_DIR}/.dk")
#		set(ENV{DKTEMP_DIR} "${DKTEMP_DIR}/.dk")
#		if(NOT EXISTS ${DKTEMP_DIR})
#			dk_makeDirectory("${DKTEMP_DIR}")
#		endif()
#	endif()
#	
#	if(NOT EXISTS "${DKTEMP_DIR}")
#		dk_fatal("unable to set .dk directory")
#	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc("\${ARGV}")
 
    dk_DKHOME_DIR()
    dk_printVar(DKHOME_DIR)
endfunction()
