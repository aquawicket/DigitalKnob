#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_DKHOME_DIR()
#
#
function(dk_DKHOME_DIR)
    dk_debugFunc()

	if(EXISTS "${DKHOME_DIR}")
		dk_debug("DKHOME_DIR:${DKHOME_DIR} already set")
		return()
	endif()
    
	###### CMD_EXE ######
	if(NOT EXISTS "${CMD_EXE}")
		dk_findProgram(CMD_EXE cmd.exe)
	endif()
	if(NOT EXISTS "${CMD_EXE}")
		dk_set(CMD_EXE "/mnt/c/Windows/System32/cmd.exe")
	endif()
	if(NOT EXISTS "${CMD_EXE}")
		dk_warning("CMD_EXE:${CMD_EXE} not found")
	else()
		dk_set(CMD_EXE "${CMD_EXE}")				# Globalize the variable
		dk_printVar(CMD_EXE)
		set(ENV{CMD_EXE} "${CMD_EXE}")				# Set Environment Varible
		dk_printVar(ENV{CMD_EXE})
	endif()
	
	###### CYGPATH_EXE ######
	if(NOT EXISTS "${CYGPATH_EXE}")
		dk_findProgram(CYGPATH_EXE cygpath)
	endif()
	if(NOT EXISTS "${CYGPATH_EXE}")
		dk_warning("CYGPATH_EXE:${CYGPATH_EXE} not found")
	else()
		dk_set(CYGPATH_EXE "${CYGPATH_EXE}")		# Globalize the variable
		dk_printVar(CYGPATH_EXE)
		set(ENV{CYGPATH_EXE} "${CYGPATH_EXE}")		# Set Environment Varible
		dk_printVar(ENV{CYGPATH_EXE})
	endif()
	
	###### WSLPATH_EXE ######
	if(NOT EXISTS "${WSLPATH_EXE}")
		dk_findProgram(WSLPATH_EXE wslpath)
	endif()
	if(NOT EXISTS "${WSLPATH_EXE}")
		dk_warning("WSLPATH_EXE:${WSLPATH_EXE} not found")
	else()
		dk_set(WSLPATH_EXE "${WSLPATH_EXE}")		# Globalize the variable
		dk_printVar(WSLPATH_EXE)
		set(ENV{WSLPATH_EXE} "${WSLPATH_EXE}")		# Set Environment Varible
		dk_printVar(ENV{WSLPATH_EXE})
	endif()
	
	###### DKHOME_DIR ######
	if(NOT EXISTS "${DKHOME_DIR}")
		dk_debug("setting DKHOME_DIR from environment variable DKHOME_DIR:$ENV{DKHOME_DIR}")
		set(DKHOME_DIR "$ENV{DKHOME_DIR}")
	endif()
	if(NOT EXISTS "${DKHOME_DIR}")
		if(CMD_EXE)	
			execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()
		if(WSLPATH_EXE)
			dk_debug("setting DKHOME_DIR from WSLPATH %USERPROFILE%")
			execute_process(COMMAND ${WSLPATH_EXE} -u "${DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()
	endif()
	if(NOT EXISTS "${DKHOME_DIR}")
		if(CMD_EXE)	
			execute_process(COMMAND ${CMD_EXE} /c "echo %USERPROFILE%" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()
		if(CYGPATH_EXE)
			dk_debug("setting CYGPATH_EXE from CYGPATH %USERPROFILE%")
			execute_process(COMMAND ${CYGPATH_EXE} -u "${DKHOME_DIR}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()
	endif()
	if(NOT EXISTS "${DKHOME_DIR}")
		dk_debug("setting DKHOME_DIR from environment variable ENV{USERPROFILE}:$ENV{USERPROFILE}")
		set(DKHOME_DIR "$ENV{USERPROFILE}")
	endif()
	if(NOT EXISTS "${DKHOME_DIR}")
		dk_debug("setting DKHOME_DIR from environment variable ENV{HOME}:$ENV{HOME}")
		set(DKHOME_DIR "$ENV{HOME}")
	endif()
    if(NOT EXISTS "${DKHOME_DIR}")
		dk_fatal("DKHOME_DIR:${DKHOME_DIR} not found")
	else()
		dk_replaceAll("${DKHOME_DIR}" "\\" "/" DKHOME_DIR)
		dk_set(DKHOME_DIR "${DKHOME_DIR}")				# Globalize the variable
		dk_printVar(DKHOME_DIR)
		set(ENV{DKHOME_DIR} "${DKHOME_DIR}")			# Set Environment Varible
		dk_printVar(ENV{DKHOME_DIR})
	endif()
	
	###### DKCACHE_DIR ######
	if(NOT EXISTS "${DKCACHE_DIR}")
		set(DKCACHE_DIR "${DKHOME_DIR}/.dk")
	endif()
	if(NOT EXISTS "${DKCACHE_DIR}")
		dk_makeDirectory("${DKCACHE_DIR}")
	endif()
	if(NOT EXISTS "${DKCACHE_DIR}")
		dk_fatal("DKCACHE_DIR:${DKCACHE_DIR} not found")
	else()
		dk_set(DKCACHE_DIR "${DKCACHE_DIR}")			# Globalize the variable
		dk_printVar(DKCACHE_DIR)
		set(ENV{DKCACHE_DIR} "${DKCACHE_DIR}")			# Set Environment Varible
		dk_printVar(ENV{DKCACHE_DIR})
	endif()
	
	###### DKDESKTOP_DIR ######
	if(NOT EXISTS "${DKDESKTOP_DIR}") 
		set(DKDESKTOP_DIR "${DKHOME_DIR}/Desktop")
	endif()
	if(NOT EXISTS "${DKDESKTOP_DIR}") 
		dk_warning("DKDESKTOP_DIR:${DKDESKTOP_DIR} not found")
	else()
		dk_set(DKDESKTOP_DIR "${DKDESKTOP_DIR}")		# Globalize the variable
		dk_printVar(DKDESKTOP_DIR)
		set(ENV{DKDESKTOP_DIR} "${DKDESKTOP_DIR}")		# Set Environment Varible
		dk_printVar(ENV{DKDESKTOP_DIR})
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
#		dk_set(DKTEMP_DIR "${DIGITALKNOB_DIR}/.dktemp")
#	endif()
#	
#	if(EXISTS "${DKTEMP_DIR}")
#		dk_set(DKTEMP_DIR "${DKTEMP_DIR}/.dktemp")
#		set(ENV{DKTEMP_DIR} "${DKTEMP_DIR}/.dktemp")
#		if(NOT EXISTS ${DKTEMP_DIR})
#			dk_makeDirectory("${DKTEMP_DIR}")
#		endif()
#	endif()
#	
#	if(NOT EXISTS "${DKTEMP_DIR}")
#		dk_fatal("unable to set DKTEMP_DIR")
#	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc()
 
    dk_DKHOME_DIR()
    dk_printVar(DKHOME_DIR)
	dk_printVar(DKCACHE_DIR)
	dk_printVar(DKDESKTOP_DIR)
	#dk_printVar(DKTEMP_DIR)
endfunction()
