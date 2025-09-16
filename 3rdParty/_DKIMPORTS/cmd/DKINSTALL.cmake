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


set(cmd_DEFAULT "Find") # Find, ComSpec, Unix, Wsl, Env, Find, Path
####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
	dk_debugFunc(0 1)

	
	
	######### CHECK #########
	if(NOT ARGV)
		if(DEFINED cmd_exe)
			dk_notice("cmd_exe:${cmd_exe} already set")
			return()
		endif()
		set(ARGV0 "${cmd_DEFAULT}")
	endif()
	
	dk_echo()
	dk_debug("${ARGV0}")	
	######### GET #########
	### Comspec
	if("${ARGV0}" STREQUAL "ComSpec")
		set(cmd_exe "$ENV{ComSpec}")
	### Env
	elseif("${ARGV0}" STREQUAL "Env")
		set(cmd_exe "$ENV{cmd_exe}")
	### Path
	elseif("${ARGV0}" STREQUAL "Path")
		set(cmd_exe "cmd.exe")
	### Unix
	elseif("${ARGV0}" STREQUAL "Unix")
		set(cmd_exe "/c/Windows/System32/cmd.exe")
	### Wsl
	elseif("${ARGV0}" STREQUAL "Wsl")
		set(cmd_exe "/mnt/c/Windows/System32/cmd.exe")
	### Find
	elseif("${ARGV0}" STREQUAL "Find")
		dk_findProgram(cmd_exe "cmd.exe")
	
	######### SET #########
	elseif(ARGV)
		set(cmd_exe "${ARGV0}")
	endif()
		
		
	###### OUTPUT ######
	file(TO_NATIVE_PATH "${cmd_exe}" cmd_exe)
	dk_set(cmd_exe "${cmd_exe}")
	dk_debug("\${cmd_exe} = ${cmd_exe}")
	dk_debug("\$CACHE{cmd_exe} = $CACHE{cmd_exe}")
	dk_debug("\$ENV{cmd_exe} = $ENV{cmd_exe}")
	dk_assertVar(cmd_exe)
	message("${cmd_exe}") 
	
	if(NOT EXISTS ${cmd_exe})
		dk_error("cmd_exe:${cmd_exe} not found")
	endif()

endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_depend(cmd ComSpec)
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
	DKINSTALL("C:\\Users\\Administrator\\DigitalKnob\\DKTools\\cmd\\cmd.exe")
	
	### GET (default / Find) ###
	DKINSTALL()
	
	### SET ###
	DKINSTALL("BOGUS")
	
	### GET (default / Find) ###
	DKINSTALL()

endfunction()	