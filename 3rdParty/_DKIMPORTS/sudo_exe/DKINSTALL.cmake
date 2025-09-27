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

	if(EXISTS "${sudo_exe}")
		execute_process(COMMAND "${sudo_exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if(NOT ${exit_code})
			return()
		endif()
	endif()
	
	
	if(NOT EXISTS "${sudo_exe}")
		string(REPLACE "\\" "/" windir "$ENV{windir}")
		set(sudo_exe "${windir}/System32/sudo.exe")
	endif()
	
	if(NOT EXISTS "${sudo_exe}")
		dk_findProgram(sudo_exe "sudo.exe")
	endif()

	if(NOT EXISTS "${sudo_exe}")
		set(sudo_exe "sudo.exe")
		dk_debug("sudo_exe = ${sudo_exe}")
	endif()

	### Test exists
	if(NOT EXISTS "${sudo_exe}") 
		dk_error("sudo_exe:${sudo_exe} not found")
		return()
	endif()
	
	### Test command
	execute_process(COMMAND "${sudo_exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(${exit_code})
		dk_error("sudo_exe:${sudo_exe} failed to run")
		return()
	endif()

	dk_set(sudo_exe "${sudo_exe}")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(sudo_exe)
	
	dk_validate(sudo_exe "dk_depend(sudo_exe)")
	dk_echo("sudo_exe = ${sudo_exe}")
	
	dk_validate(sudo_exe "dk_depend(sudo_exe)")
	dk_echo("sudo_exe = ${sudo_exe}")
endfunction()	