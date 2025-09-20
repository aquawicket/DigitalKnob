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


set(powershell_DEFAULT "Find") # Find, Unix, Wsl, Env, Find, Path
####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
	dk_debugFunc(0 1)
	
	
	######### CHECK #########
	if(NOT ARGV)
		if(DEFINED powershell_exe)
			dk_notice("powershell_exe:${powershell_exe} already set")
			return()
		endif()
		set(ARGV0 "${powershell_DEFAULT}")
	endif()
	
	dk_echo()
	dk_debug("${ARGV0}")	
	######### GET #########
	### Env
	if("${ARGV0}" STREQUAL "Env")
		set(powershell_exe "$ENV{powershell_exe}")
	### Path
	elseif("${ARGV0}" STREQUAL "Path")
		set(powershell_exe "C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
	### Unix
	elseif("${ARGV0}" STREQUAL "Unix")
		set(powershell_exe "/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
	### Wsl
	elseif("${ARGV0}" STREQUAL "Wsl")
		set(powershell_exe "/mnt/c/Windows/System32/WindowsPowerShell/v1.0/powershell.exe")
	### Find
	elseif("${ARGV0}" STREQUAL "Find")
		dk_findProgram(powershell_exe "powershell.exe")
	
	######### SET #########
	elseif(ARGV)
		set(powershell_exe "${ARGV0}")
	endif()
		
		
	###### OUTPUT ######
	file(TO_NATIVE_PATH "${powershell_exe}" powershell_exe)
	dk_set(powershell_exe "${powershell_exe}")
	dk_debug("\${powershell_exe} = ${powershell_exe}")
	dk_debug("\$CACHE{powershell_exe} = $CACHE{powershell_exe}")
	dk_debug("\$ENV{powershell_exe} = $ENV{powershell_exe}")
	dk_assertVar(powershell_exe)
	message("${powershell_exe}") 
	
	if(NOT EXISTS ${powershell_exe})
		dk_error("powershell_exe:${powershell_exe} not found")
	endif()

endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_depend(powershell Unix)
return()
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### GET (default / Find) ###
	DKINSTALL(Find)
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### GET (Unix) ###
	DKINSTALL(Unix)
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### GET (Wsl) ###
	DKINSTALL(Wsl)
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### GET (Env) ###
	DKINSTALL(Env)
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### GET (Path) ###
	DKINSTALL(Path)
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### SET ###
	DKINSTALL("C:\\Users\\Administrator\\DigitalKnob\\DKTools\\powershell\\powershell.exe")
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### SET ###
	DKINSTALL("BOGUS")
	
	### GET (default / Find) ###
	DKINSTALL()

endfunction()	