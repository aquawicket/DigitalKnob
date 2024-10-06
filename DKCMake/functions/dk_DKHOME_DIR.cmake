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
    
	### DKHOME_DIR ###
	if(DEFINED ENV{WSLENV})
		dk_echo("Using WSL")
		execute_process(COMMAND cmd.exe /c "echo %HOMEDRIVE%" OUTPUT_VARIABLE HOMEDRIVE OUTPUT_STRIP_TRAILING_WHITESPACE)  # TODO: extract drive letter and convert to /mnt/L
		set(HOMEDRIVE "/mnt/c")
		
		#### TODO ####
		#string(SUBSTRING "${HOMEDRIVE}" 0 1 DRIVE)
		#dk_toLower(${DRIVE} drive)
		#dk_set(HOMEDRIVE "/mnt/${drive}")
		##############
		
		execute_process(COMMAND cmd.exe /c "echo %USERPROFILE%" OUTPUT_VARIABLE HOMEPATH OUTPUT_STRIP_TRAILING_WHITESPACE)
		dk_replaceAll("${HOMEPATH}" "\\" "/" HOMEPATH)
		dk_set(DKHOME_DIR "${USERPROFILE}")
	elseif(DEFINED ENV{USERPROFILE})
		dk_set(DKHOME_DIR "$ENV{USERPROFILE}")
		#execute_process(COMMAND cygpath -u "${DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
	elseif(DEFINED ENV{HOME})
		dk_set(DKHOME_DIR "$ENV{HOME}")
	else()
		dk_fatal("dk_DKHOME_DIR(): unable to locate HOME directory")
	endif()
	
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
