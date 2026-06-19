#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
		cmake_policy(SET CMP0009 NEW)
		file(GLOB_RECURSE DK_cmake "/DK.cmake")
		list(GET DK_cmake 0 DK_cmake)
		get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK_cmake}" DIRECTORY)
		set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
	endif()
	include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
endif()
#########################################################################


#########################################################################
# DKINSTALL()
#
function(DKINSTALL)
	dk_debugFunc(0 1)
	message("DKINSTALL(${ARGV})")
	
	if(timeout_exe)
		dk_notice("timeout_exe:${timeout_exe} already set")
		return()
	endif()
	
	set(timeout_DEFAULT "Find") # Find, Windows, Unix, Wsl, Env, Path
	
	######### CHECK #########
	set(timeout_option ${ARGN})
	if(NOT timeout_option)
		set(timeout_option "${timeout_DEFAULT}")
	endif()
	message("timeout_option = ${timeout_option}")
	
	######### GET #########
	### Env
	if("${timeout_option}" STREQUAL "Env")
		set(timeout_exe "$ENV{timeout_exe}")
	### Path
	elseif("${timeout_option}" STREQUAL "Path")
		set(timeout_exe "timeout.exe")
	### Windows
	elseif("${timeout_option}" STREQUAL "Windows")
		set(timeout_exe "C:/Windows/System32/timeout.exe")
	### Unix
	elseif("${timeout_option}" STREQUAL "Unix")
		set(timeout_exe "/c/Windows/System32/timeout.exe")
	### Wsl
	elseif("${timeout_option}" STREQUAL "Wsl")
		set(timeout_exe "/mnt/c/Windows/System32/timeout.exe")
	### Find
	elseif("${timeout_option}" STREQUAL "Find")
		dk_findProgram(timeout_exe "timeout.exe")
	
	######### SET #########
	elseif(ARGV)
		set(timeout_exe "${ARGV0}")
		
	else()
		set(timeout_exe "timeout.exe")
	endif()
		
		
	###### return ######
	#file(TO_NATIVE_PATH "${timeout_exe}" timeout_exe)
	dk_pathToNative("${timeout_exe}" timeout_exe)
	dk_set(timeout_exe "${timeout_exe}")
	dk_debug("\${timeout_exe} = ${timeout_exe}")
	dk_debug("\$CACHE{timeout_exe} = $CACHE{timeout_exe}")
	dk_debug("\$ENV{timeout_exe} = $ENV{timeout_exe}")
	dk_assertVar(timeout_exe)
	dk_echo("${timeout_exe}") 
	
	if(NOT EXISTS ${timeout_exe})
		dk_error("timeout_exe:${timeout_exe} NOT FOUND")
	endif()

endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_validate(timeout_exe "dk_depend(timeout)")
	return()
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### GET (default / Find) ###
	DKINSTALL(Find)
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### GET (ComSpec) ###
	DKINSTALL(ComSpec)
	
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
	DKINSTALL("C:\\Users\\Administrator\\DigitalKnob\\DKTools\\timeout\\timeout.exe")
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### SET ###
	DKINSTALL("BOGUS")
	
	### GET (default / Find) ###
	DKINSTALL()

endfunction()	