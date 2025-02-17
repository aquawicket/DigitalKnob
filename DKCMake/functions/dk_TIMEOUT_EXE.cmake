#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
include_guard()

####################################################################
# dk_TIMEOUT_EXE()
#
#
function(dk_TIMEOUT_EXE)
    dk_debugFunc()

	if(EXISTS "${TIMEOUT_EXE}")
		dk_debug("TIMEOUT_EXE:${TIMEOUT_EXE} already set")
		return()
	endif()
	
	###### TIMEOUT_EXE ######
	if(NOT EXISTS "${TIMEOUT_EXE}")
		dk_findProgram(TIMEOUT_EXE "timeout.exe")
	endif()
	if(NOT EXISTS "${TIMEOUT_EXE}")
		dk_set(TIMEOUT_EXE "$ENV{TIMEOUT_EXE}")
	endif()
	if(NOT EXISTS "${TIMEOUT_EXE}")
		dk_set(TIMEOUT_EXE "/c/Windows/System32/cmd.exe")
	endif()
	if(NOT EXISTS "${TIMEOUT_EXE}")
		dk_set(TIMEOUT_EXE "/mnt/c/Windows/System32/cmd.exe")
	endif()
	if(NOT EXISTS "${TIMEOUT_EXE}")
		dk_warning("TIMEOUT_EXE:${TIMEOUT_EXE} not found")
	else()
		dk_set(TIMEOUT_EXE "${TIMEOUT_EXE}")				# Globalize the variable
		set(ENV{TIMEOUT_EXE} "${TIMEOUT_EXE}")				# Set Environment Varible
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
    dk_TIMEOUT_EXE()
    dk_printVar(TIMEOUT_EXE)
endfunction()
