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
# dk_DKHOME_DIR()
#
#
function(dk_DKHOME_DIR)
	dk_debugFunc(0 1)

	###### SET ######
	if(ARGV)
		dk_set(DKHOME_DIR "${ARGV}")
		return()
	endif()
	
	###### GET ######

	############ from ENV{DKHOME_DIR} ############
	if(NOT EXISTS "${DKHOME_DIR}")
		set(DKHOME_DIR "$ENV{DKHOME_DIR}")
	endif()

	########### from CMD #############
	if(NOT EXISTS "${DKHOME_DIR}")
	#if("${CMAKE_HOST_SYSTEM_NAME}" EQUAL "Windows")
		file(TO_CMAKE_PATH "$ENV{USERPROFILE}" DKHOME_DIR)
	#endif()
	endif()
	
	########### from MSYS ###########
	if(NOT EXISTS "${DKHOME_DIR}")
		set(CYGPATH_EXE "/usr/bin/cygpath.exe")
		if(EXISTS "${CYGPATH_EXE}")
			execute_process(COMMAND ${CYGPATH_EXE} -u "$ENV{USERPROFILE}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()
	endif()
		
	########### from WSL ###########
	if(NOT EXISTS "${DKHOME_DIR}")
		set(WSLPATH_EXE "wsl.exe")
		if(EXISTS "${WSLPATH_EXE}")
			execute_process(COMMAND ${WSLPATH_EXE} -u "$ENV{USERPROFILE}" OUTPUT_VARIABLE DKHOME_DIR OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()
	endif()

	########### from Unix ############
	if(NOT EXISTS "${DKHOME_DIR}")
		file(REAL_PATH "~" DKHOME_DIR EXPAND_TILDE) # EXPAND_TILDE - Added in version 3.21.
	endif()
		

	
	
	

	
#	###### CMD_EXE ######
#	dk_validate(CMD_EXE "dk_CMD_EXE()")
#	if(NOT EXISTS "${CMD_EXE}")
#		dk_set(CMD_EXE "/mnt/c/Windows/System32/cmd.exe")
#	endif()
	
#	if(NOT EXISTS "${CMD_EXE}")
#		dk_warning("CMD_EXE:${CMD_EXE} not found")
#	else()
#		dk_set(CMD_EXE "${CMD_EXE}")
#		dk_printVar(CMD_EXE)
#	endif()

#	###### CYGPATH_EXE ######
#	if(NOT EXISTS "${CYGPATH_EXE}")
#		if(EXISTS "/usr/bin/cygpath.exe")
#			dk_set(CYGPATH_EXE "/usr/bin/cygpath.exe")
#		endif()
#	endif()
#	if(CMD_EXE)
#			execute_process(COMMAND where /R C:\\Users\\Administrator cygpath.exe OUTPUT_VARIABLE CYGPATH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
#			dk_printVar(CYGPATH_EXE)
#		endif()
#	endif()
#	if(NOT EXISTS "${CYGPATH_EXE}")
#		execute_process(COMMAND $ENV{DKSHELL} -c "command -v cygpath" OUTPUT_VARIABLE CYGPATH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
#	endif()
#	if(NOT EXISTS "${CYGPATH_EXE}")
#		dk_findProgram(CYGPATH_EXE cygpath.exe)
#	endif()
#	if(NOT EXISTS "${CYGPATH_EXE}")
#		dk_warning("CYGPATH_EXE:${CYGPATH_EXE} not found")
#	else()
#		dk_set(CYGPATH_EXE "${CYGPATH_EXE}")		# Globalize the variable
#		dk_printVar(CYGPATH_EXE)
#		set(ENV{CYGPATH_EXE} "${CYGPATH_EXE}")		# Set Environment Varible
#		dk_printVar(ENV{CYGPATH_EXE})
#	endif()

#	###### WSLPATH_EXE ######
#	if(NOT EXISTS "${WSLPATH_EXE}")
#		dk_findProgram(WSLPATH_EXE wslpath)
#	endif()
#	if(NOT EXISTS "${WSLPATH_EXE}")
#		dk_warning("WSLPATH_EXE:${WSLPATH_EXE} not found")
#	else()
#		dk_set(WSLPATH_EXE "${WSLPATH_EXE}")		# Globalize the variable
#		dk_printVar(WSLPATH_EXE)
#		set(ENV{WSLPATH_EXE} "${WSLPATH_EXE}")		# Set Environment Varible
#		dk_printVar(ENV{WSLPATH_EXE})
#	endif()


	if(NOT EXISTS "${DKHOME_DIR}")
		dk_fatal("DKHOME_DIR:'${DKHOME_DIR}' not found")
	endif()
	
	dk_set(DKHOME_DIR "${DKHOME_DIR}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
 
	dk_echo()
	dk_echo("Test Getting DKHOME_DIR . . .")
	dk_DKHOME_DIR()
	dk_echo("DKHOME_DIR = ${DKHOME_DIR}")
	
	dk_echo()
	dk_echo("Test Setting DKHOME_DIR . . .")
	dk_DKHOME_DIR("C:/")
	dk_echo("DKHOME_DIR = ${DKHOME_DIR}")
endfunction()
