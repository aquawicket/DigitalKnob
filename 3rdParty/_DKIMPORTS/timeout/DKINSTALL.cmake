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


set(timeout_DEFAULT "Find") # Find, Unix, Wsl, Env, Find, Path
####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
	dk_debugFunc(0 1)


	######### CHECK #########
	if(NOT ARGV)
		if(DEFINED timeout_exe)
			dk_notice("timeout_exe:${timeout_exe} already set")
			return()
		endif()
		set(ARGV0 "${timeout_DEFAULT}")
	endif()
	
	######### GET #########
	### Env
	if("${ARGV0}" STREQUAL "Env")
		set(timeout_exe "$ENV{timeout_exe}")
	### Path
	elseif("${ARGV0}" STREQUAL "Path")
		set(timeout_exe "timeout.exe")
	### Unix
	elseif("${ARGV0}" STREQUAL "Unix")
		set(timeout_exe "/c/Windows/System32/timeout.exe")
	### Wsl
	elseif("${ARGV0}" STREQUAL "Wsl")
		set(timeout_exe "/mnt/c/Windows/System32/timeout.exe")
	### Find
	elseif("${ARGV0}" STREQUAL "Find")
		dk_findProgram(timeout_exe "timeout.exe")
	
	######### SET #########
	elseif(ARGV)
		set(timeout_exe "${ARGV0}")
	endif()
		
		
	###### OUTPUT ######
	file(TO_NATIVE_PATH "${timeout_exe}" timeout_exe)
	dk_set(timeout_exe "${timeout_exe}")
	dk_debug("\${timeout_exe} = ${timeout_exe}")
	dk_debug("\$CACHE{timeout_exe} = $CACHE{timeout_exe}")
	dk_debug("\$ENV{timeout_exe} = $ENV{timeout_exe}")
	dk_assertVar(timeout_exe)
	message("${timeout_exe}") 
	
	if(NOT EXISTS ${timeout_exe})
		dk_error("timeout_exe:${timeout_exe} not found")
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