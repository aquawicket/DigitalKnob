#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DKHOME_DIR()
#
#
function(dk_DKHOME_DIR)
    dk_debugFunc("\${ARGV}")

    if(DEFINED ENV{DKHOME_DIR})
		return()
	endif()
    
	
	###### DKDRIVE ######
	if(NOT EXISTS "$ENV{DKDRIVE}")
		dk_set(ENV{DKDRIVE} "/c")
	endif()
	if(NOT EXISTS "$ENV{DKDRIVE}")
		dk_set(ENV{DKDRIVE} "/mnt/c")
	endif()
	if(NOT EXISTS "$ENV{DKDRIVE}")
		dk_unset(ENV{DKDRIVE})
	endif()
	if(EXISTS "$ENV{DKDRIVE}")
		dk_printVar(ENV{DKDRIVE})
	endif()
	
	
	###### CMD_EXE ######
	if(NOT EXISTS "$ENV{CMD_EXE}")
		#dk_set(ENV{CMD_EXE} $(command -v cmd.exe)) 		#TODO
	endif()
	if(NOT EXISTS "$ENV{CMD_EXE}")
		dk_set(ENV{CMD_EXE} "${DKDRIVE}/Windows/System32/cmd.exe")
	endif()
	if(NOT EXISTS "$ENV{CMD_EXE}")
		dk_unset(ENV{CMD_EXE})
	endif()
	if(EXISTS "$ENV{CMD_EXE}")
		dk_printVar(ENV{CMD_EXE})
	endif()
	
	
	###### CYGPATH_EXE ######
	if(NOT EXISTS "$ENV{CYGPATH_EXE}")
		#dk_set(ENV{CYGPATH_EXE} "$(command -v "cygpath")") 		 #TODO
	endif()
	if(NOT EXISTS "$ENV{CYGPATH_EXE}")
		#dk_set(ENV{USERPROFILE} "$(${CYGPATH_EXE} -u $(${CMD_EXE} "/c echo %USERPROFILE% | tr -d '\r'"))"   #TODO
		execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE USERPROFILE OUTPUT_STRIP_TRAILING_WHITESPACE)  # TODO: extract drive letter and convert to /mnt/L
		execute_process(COMMAND ${CYGPATH_EXE} -u "${USERPROFILE}" OUTPUT_VARIABLE ENV{USERPROFILE} OUTPUT_STRIP_TRAILING_WHITESPACE) 
	endif()
	if(NOT EXISTS "$ENV{CYGPATH_EXE}")
		dk_unset(ENV{CYGPATH_EXE})
	endif()
	if(EXISTS "$ENV{CYGPATH_EXE}")
		dk_printVar(ENV{CYGPATH_EXE})
	endif()
	
	
	###### WSLPATH_EXE ######
	if(NOT EXISTS "$ENV{WSLPATH_EXE}")
		#dk_set(ENV{WSLPATH_EXE} "$(command -v "wslpath")")	#TODO
	endif()
	if(EXISTS "$ENV{WSLPATH_EXE}")
		#dk_set(ENV{USERPROFILE} "$(${WSLPATH_EXE} -u $(${CMD_EXE} /c echo "%USERPROFILE%" | tr -d '\r'))") 	#TODO
		execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE USERPROFILE OUTPUT_STRIP_TRAILING_WHITESPACE)  # TODO: extract drive letter and convert to /mnt/L
		execute_process(COMMAND ${WSLPATH_EXE} -u "${USERPROFILE}" OUTPUT_VARIABLE ENV{USERPROFILE} OUTPUT_STRIP_TRAILING_WHITESPACE) 
	endif()
	if(NOT EXISTS "$ENV{WSLPATH_EXE}")
		dk_unset(ENV{WSLPATH_EXE})
	endif()
	if(EXISTS "$ENV{WSLPATH_EXE}")
		dk_printVar(ENV{WSLPATH_EXE})
	endif()
	
	
	###### DKHOME_DIR ######
	if(NOT EXISTS "$ENV{WSLPATH_EXE}")
		dk_set(ENV{DKHOME_DIR} "$ENV{USERPROFILE}")
	endif()
	if(NOT EXISTS "$ENV{WSLPATH_EXE}")
		dk_set(ENV{DKHOME_DIR} "$ENV{HOME}")
	endif()
	if(NOT EXISTS "$ENV{WSLPATH_EXE}")
		dk_set(ENV{DKHOME_DIR} "$ENV{PWD}")
	endif()
	if(NOT EXISTS "$EN{WSLPATH_EXE}")
		dk_error("dk_DKHOME_DIR(): unable to locate DKHOME_DIR directory")
	endif()
	dk_printVar(ENV{DKHOME_DIR})
	
	
	###### DKCACHE_DIR ######
	dk_set(ENV{DKCACHE_DIR} "$ENV{DKHOME_DIR}/.dk")
	if(NOT EXISTS "$ENV{DKCACHE_DIR}")
		dk_makeDirectory("$ENV{DKCACHE_DIR}")
	endif()
	dk_printVar(ENV{DKCACHE_DIR})
	
	
	###### DKDESKTOP_DIR ######
	dk_set(ENV{DKDESKTOP_DIR} "$ENV{DKHOME_DIR}/Desktop")
    if(NOT EXISTS "$ENV{DKDESKTOP_DIR}")
		dk_fatal("DKDESKTOP_DIR:$ENV{DKDESKTOP_DIR} does not exist")
	endif()
	dk_printVar(ENV{DKDESKTOP_DIR})
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	#if(DEFINED ENV{WSLENV})
	if(DEFINED ENV{WSLPATH_EXE})
		dk_echo("Using WSL")
		execute_process(COMMAND cmd.exe /c "echo %HOMEDRIVE%" OUTPUT_VARIABLE HOMEDRIVE OUTPUT_STRIP_TRAILING_WHITESPACE)  # TODO: extract drive letter and convert to /mnt/L
		set(HOMEDRIVE "/mnt/c")
		
		#### TODO ####
		#string(SUBSTRING "${HOMEDRIVE}" 0 1 DRIVE)
		#dk_toLower(${DRIVE} drive)
		#dk_set(HOMEDRIVE "/mnt/${drive}")
		##############
		
		execute_process(COMMAND cmd.exe /c "echo %HOMEPATH%" OUTPUT_VARIABLE HOMEPATH OUTPUT_STRIP_TRAILING_WHITESPACE)
		dk_replaceAll("${HOMEPATH}" "\\" "/" HOMEPATH)
		dk_set(DKHOME_DIR "${HOMEDRIVE}${HOMEPATH}")
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
