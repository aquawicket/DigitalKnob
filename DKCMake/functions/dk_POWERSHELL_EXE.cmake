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
# dk_POWERSHELL_EXE()
#
#
function(dk_POWERSHELL_EXE)
    dk_debugFunc()

	if(EXISTS "${POWERSHELL_EXE}")
		dk_debug("POWERSHELL_EXE:${POWERSHELL_EXE} already set")
		return()
	endif()
	
	
	### from POWERSHELL_EXE environment variable ###
	if(NOT EXISTS "${POWERSHELL_EXE}")
		dk_set(POWERSHELL_EXE "$ENV{POWERSHELL_EXE}")
	endif()
	
	### from powershell (Get-Process -Id $pid).Path ###
	if(NOT EXISTS "${POWERSHELL_EXE}")
		execute_process(COMMAND powershell -c Write-Host "(Get-Process -Id $pid).Path" OUTPUT_VARIABLE POWERSHELL_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
		file(TO_CMAKE_PATH "${POWERSHELL_EXE}" POWERSHELL_EXE)
	endif()
	
	### from dk_findProgram ###
	if(NOT EXISTS "${POWERSHELL_EXE}")
		dk_findProgram(POWERSHELL_EXE "powershell.exe")
	endif()
	
	### from raw unix path ###
	if(NOT EXISTS "${POWERSHELL_EXE}")
		dk_set(POWERSHELL_EXE "/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
	endif()
	
	### from raw wsl path ###
	if(NOT EXISTS "${POWERSHELL_EXE}")
		dk_set(POWERSHELL_EXE "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
	endif()
	
	if(NOT EXISTS "${POWERSHELL_EXE}")
		dk_warning("POWERSHELL_EXE:${POWERSHELL_EXE} not found")
	else()
		dk_set(POWERSHELL_EXE "${POWERSHELL_EXE}")	# Globalize the variable
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
    dk_debugFunc(0)
 
    dk_POWERSHELL_EXE()
	if(EXISTS "${POWERSHELL_EXE}")
		dk_success("POWERSHELL_EXE = ${POWERSHELL_EXE}")
	else()
		dk_error("POWERSHELL_EXE = ${POWERSHELL_EXE}")
	endif()
endfunction()
