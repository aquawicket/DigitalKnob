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


set(curl_DEFAULT "Find") # Find, ComSpec, Unix, Wsl, Env, Find, Path
####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
	dk_debugFunc(0 1)

	######### CHECK #########
	if(NOT ARGV)
		if(DEFINED curl_exe)
			dk_notice("curl_exe:${curl_exe} already set")
			return()
		endif()
		set(ARGV0 "${curl_DEFAULT}")
	endif()

	######### GET #########
	### Env
	if("${ARGV0}" STREQUAL "Env")
		set(curl_exe "$ENV{curl_exe}")
	### Path
	elseif("${ARGV0}" STREQUAL "Path")
		set(curl_exe "C:/Windows/System32/curl.exe")
	### Unix
	elseif("${ARGV0}" STREQUAL "Unix")
		set(curl_exe "/c/Windows/System32/curl.exe")
	### Wsl
	elseif("${ARGV0}" STREQUAL "Wsl")
		set(curl_exe "/mnt/c/Windows/System32/curl.exe")
	### Find
	elseif("${ARGV0}" STREQUAL "Find")
		dk_findProgram(curl_exe "curl.exe")
	
	######### SET #########
	elseif(ARGV)
		set(curl_exe "${ARGV0}")
	endif()
		
		
	###### OUTPUT ######
	file(TO_NATIVE_PATH "${curl_exe}" curl_exe)
	dk_set(curl_exe "${curl_exe}")
	#dk_debug("\${curl_exe} = ${curl_exe}")
	#dk_debug("\$CACHE{curl_exe} = $CACHE{curl_exe}")
	#dk_debug("\$ENV{curl_exe} = $ENV{curl_exe}")
	dk_assertVar(curl_exe)
	
	if(NOT EXISTS ${curl_exe})
		dk_error("curl_exe:${curl_exe} not found")
	endif()

	#dk_exec(${curl_exe})
	
	#dk_debug("${curl_exe}") 
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_validate(curl_exe "dk_depend(curl_exe)")
	dk_notice("curl_exe = ${curl_exe}")
endfunction()	