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


#set(powershell_DEFAULT "Find") # Find, Unix, Wsl, Env, Find, Path
####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
    dk_debugFunc()

	if(EXISTS "${powershell_exe}")
		dk_debug("powershell_exe:${powershell_exe} already set")
		return()
	endif()
	
	
	### from powershell_exe environment variable ###
	if(NOT EXISTS "${powershell_exe}")
		dk_set(powershell_exe "$ENV{powershell_exe}")
	endif()
	
	### from powershell (Get-Process -Id $pid).Path ###
	if(NOT EXISTS "${powershell_exe}")
		execute_process(COMMAND powershell -c Write-Host "(Get-Process -Id $pid).Path" OUTPUT_VARIABLE powershell_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
		file(TO_CMAKE_PATH "${powershell_exe}" powershell_exe)
	endif()
	
	### from dk_findProgram ###
	if(NOT EXISTS "${powershell_exe}")
		dk_findProgram(powershell_exe "powershell.exe")
	endif()
	
	### from raw unix path ###
	if(NOT EXISTS "${powershell_exe}")
		dk_set(powershell_exe "/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
	endif()
	
	### from raw wsl path ###
	if(NOT EXISTS "${powershell_exe}")
		dk_set(powershell_exe "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
	endif()
	
	if(NOT EXISTS "${powershell_exe}")
		dk_warning("powershell_exe:${powershell_exe} not found")
	else()
		dk_set(powershell_exe "${powershell_exe}")	# Globalize the variable
	endif()
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_validate(powershell_exe "dk_depend(powershell_exe)")
	dk_debug("powershell_exe = ${powershell_exe}")

endfunction()	