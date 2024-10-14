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
    
	###### CMD_EXE ######
	dk_findProgram(CMD_EXE cmd.exe)
	if(NOT EXISTS ${CMD_EXE})
		dk_set(CMD_EXE "/mnt/c/Windows/System32/cmd.exe")
	endif()
	message("CMD_EXE = ${CMD_EXE}")

	###### CYGPATH_EXE ######
	dk_findProgram(CYGPATH_EXE cygpath)
	message("CYGPATH_EXE = ${CYGPATH_EXE}")
	
	###### WSLPATH_EXE ######
	dk_findProgram(WSLPATH_EXE wslpath)
	message("WSLPATH_EXE = ${WSLPATH_EXE}")
	
	### DKHOME_DIR ###
	if(DEFINED ENV{DKHOME_DIR})
		message("getting DKHOME_DIR from DKHOME_DIR")
		set(DKHOME_DIR $ENV{DKHOME_DIR})
	elseif(WSLPATH_EXE)
		dk_echo("Using WSL")
		execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		execute_process(COMMAND ${WSLPATH_EXE} -u "${DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
	elseif(CYGPATH_EXE)
		set(DKHOME_DIR "$ENV{USERPROFILE}")
		execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		execute_process(COMMAND ${CYGPATH_EXE} -u "${DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
	elseif(DEFINED ENV{USERPROFILE})
		set(DKHOME_DIR "$ENV{USERPROFILE}")
	elseif(DEFINED ENV{HOME})
		set(DKHOME_DIR "$ENV{HOME}")
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
		dk_warning("DKDESKTOP_DIR does not exist")
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
	dk_printVar(DKCACHE_DIR)
	dk_printVar(DKDESKTOP_DIR)
endfunction()
