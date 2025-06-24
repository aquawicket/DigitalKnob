#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()
#########################################################################

####################################################################
# dk_CMD_EXE()
#
#
function(dk_CMD_EXE)
    dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(CMD_EXE "${ARGV0}")
		
	###### GET ######
	elseif(EXIST ${CMD_EXE})	
		#dk_set(CMD_EXE "$ENV{CMD_EXE}")
	
	else()
		if(EXISTS "${CMD_EXE}")
			dk_debug("CMD_EXE:${CMD_EXE} already set")
			return()
		endif()
		
		### from CMD_EXE environment variable ###
		if(NOT EXISTS "${CMD_EXE}")
			dk_set(CMD_EXE "$ENV{CMD_EXE}")
		endif()
		
		### from COMSPEC environment variable ###
		if(NOT EXISTS "${CMD_EXE}")
			dk_set(CMD_EXE "$ENV{ComSpec}")
		endif()
		
		### from dk_findProgram ###
		if(NOT EXISTS "${CMD_EXE}")
			dk_findProgram(CMD_EXE "cmd.exe")
		endif()
		
		### from raw Unix path
		if(NOT EXISTS "${CMD_EXE}")
			dk_set(CMD_EXE "/c/Windows/System32/cmd.exe")
		endif()
		
		### from raw Wsl path
		if(NOT EXISTS "${CMD_EXE}")
			dk_set(CMD_EXE "/mnt/c/Windows/System32/cmd.exe")
		endif()
	endif()
	
	###### FINALIZE ######
	dk_assertPath(CMD_EXE)
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
	dk_CMD_EXE()
	if(EXISTS ${CMD_EXE})
		dk_success("CMD_EXE = ${CMD_EXE}")
	else()
		dk_error("CMD_EXE = ${CMD_EXE}")
	endif()
endfunction()
