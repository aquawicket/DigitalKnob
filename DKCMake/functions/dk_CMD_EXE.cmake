#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

####################################################################
# dk_CMD_EXE()
#
#
function(dk_CMD_EXE)
    dk_debugFunc()

	if(EXISTS "${CMD_EXE}")
		dk_debug("CMD_EXE:${CMD_EXE} already set")
		return()
	endif()
	
	###### CMD_EXE ######
	if(NOT EXISTS "${CMD_EXE}")
		dk_findProgram(CMD_EXE cmd.exe)
	endif()
	if(NOT EXISTS "${CMD_EXE}")
		dk_set(CMD_EXE "$ENV{COMSPEC}")
	endif()
	if(NOT EXISTS "${CMD_EXE}")
		dk_set(CMD_EXE "$ENV{CMD_EXE}")
	endif()
	if(NOT EXISTS "${CMD_EXE}")
		dk_set(CMD_EXE "/c/Windows/System32/cmd.exe")
	endif()
	if(NOT EXISTS "${CMD_EXE}")
		dk_set(CMD_EXE "/mnt/c/Windows/System32/cmd.exe")
	endif()
	if(NOT EXISTS "${CMD_EXE}")
		dk_warning("CMD_EXE:${CMD_EXE} not found")
	else()
		dk_set(CMD_EXE "${CMD_EXE}")				# Globalize the variable
		set(ENV{CMD_EXE} "${CMD_EXE}")				# Set Environment Varible
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
    dk_CMD_EXE()
    dk_printVar(CMD_EXE)
endfunction()
