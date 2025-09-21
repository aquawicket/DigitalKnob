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



####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
	dk_debugFunc(0 1)

	if(EXISTS "${wsl_exe}")
		execute_process(COMMAND "${wsl_exe}" --status RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if(NOT ${exit_code})
			return()
		endif()
	endif()
	
	
	if(NOT EXISTS "${wsl_exe}")
		string(REPLACE "\\" "/" windir "$ENV{windir}")
		set(wsl_exe "${windir}/System32/wsl.exe")
	endif()
	
	if(NOT EXISTS "${wsl_exe}")
		dk_findProgram(wsl_exe "wsl.exe")
	endif()

	if(NOT EXISTS "${wsl_exe}")
		set(wsl_exe "wsl.exe")
		dk_debug("wsl_exe = ${wsl_exe}")
	endif()

	### Test exists
	if(NOT EXISTS "${wsl_exe}") 
		dk_error("wsl_exe:${wsl_exe} not found")
		return()
	endif()
	
	### Test command
	execute_process(COMMAND "${wsl_exe}" --status RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(${exit_code})
		dk_error("wsl_exe:${wsl_exe} failed to run")
		return()
	endif()

	dk_set(wsl_exe "${wsl_exe}")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(wsl_exe)
	
	dk_validate(wsl_exe "dk_depend(wsl_exe)")
	dk_echo("wsl_exe = ${wsl_exe}")
	
	dk_validate(wsl_exe "dk_depend(wsl_exe)")
	dk_echo("wsl_exe = ${wsl_exe}")
endfunction()	