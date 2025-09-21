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


set(reg_DEFAULT "Find") # Find, ComSpec, Unix, Wsl, Env, Find, Path
####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
	dk_debugFunc(0 1)

	######### CHECK #########
	if(NOT ARGV)
		if(DEFINED reg_exe)
			dk_notice("reg_exe:${reg_exe} already set")
			return()
		endif()
		set(ARGV0 "${reg_DEFAULT}")
	endif()

	######### GET #########
	### Env
	if("${ARGV0}" STREQUAL "Env")
		set(reg_exe "$ENV{reg_exe}")
	### Path
	elseif("${ARGV0}" STREQUAL "Path")
		set(reg_exe "C:/Windows/System32/reg.exe")
	### Unix
	elseif("${ARGV0}" STREQUAL "Unix")
		set(reg_exe "/c/Windows/System32/reg.exe")
	### Wsl
	elseif("${ARGV0}" STREQUAL "Wsl")
		set(reg_exe "/mnt/c/Windows/System32/reg.exe")
	### Find
	elseif("${ARGV0}" STREQUAL "Find")
		dk_findProgram(reg_exe "reg.exe")
	
	######### SET #########
	elseif(ARGV)
		set(reg_exe "${ARGV0}")
	endif()
		
		
	###### OUTPUT ######
	file(TO_NATIVE_PATH "${reg_exe}" reg_exe)
	dk_set(reg_exe "${reg_exe}")
	#dk_debug("\${reg_exe} = ${reg_exe}")
	#dk_debug("\$CACHE{reg_exe} = $CACHE{reg_exe}")
	#dk_debug("\$ENV{reg_exe} = $ENV{reg_exe}")
	dk_assertVar(reg_exe)
	
	if(NOT EXISTS ${reg_exe})
		dk_error("reg_exe:${reg_exe} not found")
	endif()

	#dk_exec(${reg_exe})
	
	#dk_debug("${reg_exe}") 
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_validate(reg_exe "dk_depend(reg_exe)")
	dk_notice("reg_exe = ${reg_exe}")
endfunction()	