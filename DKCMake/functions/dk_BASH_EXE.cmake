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


#########################################################################
# dk_bash_exe()
#
#
function(dk_bash_exe)
	dk_debugFunc()

	###### SET ######
	if(ARGV)
		dk_set(bash_exe "${ARGV0}")
		
	###### GET ######
	elseif(DEFINED ENV{bash_exe})	
		dk_set(bash_exe "$ENV{bash_exe}")
	
	else()
		### Already found ###
		if(EXISTS "${bash_exe}")
			dk_debug("bash_exe:${bash_exe} already set")
			return()
		endif()

		### from bash_exe environment variable ###
		if(NOT EXISTS "${bash_exe}")
			dk_set(cmd_exe "$ENV{bash_exe}")
			dk_error("dk_BASH_EXE():39  cmd_exe should be bash_exe")
		endif()
		
		### from BASH environment variable ###
		if(NOT EXISTS "${bash_exe}")
			if("$ENV{BASH}" MATCHES "/bash")
				set(bash_exe "$ENV{BASH}")
			endif()
		endif()
		
		### from SHELL environment variable ###
		if(NOT EXISTS "${bash_exe}")
			if("$ENV{SHELL}" MATCHES "/bash")
				set(bash_exe "$ENV{SHELL}")
			endif()
		endif()
		
		### From command -v ###
		if(NOT EXISTS "${bash_exe}")
			execute_process(COMMAND command -v bash OUTPUT_VARIABLE bash_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
		endif()

		### from dk_findProgram in Msys2 ###
		if(NOT EXISTS "${bash_exe}")
			dk_validate(msys2 "dk_depend(msys2)")
			dk_findProgram(MSYS2_bash_exe bash "${msys2}/usr/bin")
			set(bash_exe ${msys2_bash_exe})
		endif()
	endif()
	
	### FINALIZE ###
	#file(TO_CMAKE_PATH "${bash_exe}" bash_exe)
	if(NOT EXISTS "${bash_exe}")
		dk_warning("bash_exe:${bash_exe} not found")
	else()
		dk_set(bash_exe "${bash_exe}") # Globalize the variable
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo()
	dk_echo("Test Getting bash_exe . . .")
	dk_bash_exe()
	if(EXISTS "${bash_exe}")
		dk_success("bash_exe = ${bash_exe}")
	else()
		dk_error("bash_exe = ${bash_exe}")
	endif()
	
	dk_echo()
	dk_echo("Test Setting bash_exe . . .")
	dk_bash_exe("C:/bash.exe")
	if(EXISTS "${bash_exe}")
		dk_success("bash_exe = ${bash_exe}")
	else()
		dk_error("bash_exe = ${bash_exe}")
	endif()
endfunction()
