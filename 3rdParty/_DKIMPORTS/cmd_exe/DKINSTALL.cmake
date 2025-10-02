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

	### Test if already valid
	if(EXISTS "${cmd_exe}")
		execute_process(COMMAND ${cmd_exe} /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if(NOT ${exit_code})
			return()
		endif()
	endif()
	
	
	if(NOT EXISTS "${cmd_exe}")
		file(TO_NATIVE_PATH "$ENV{ComSpec}" cmd_exe)
	endif()
	
	if(NOT EXISTS "${cmd_exe}")
		string(REPLACE "\\" "/" windir "$ENV{windir}")
		file(TO_NATIVE_PATH "${windir}/System32/cmd.exe" cmd_exe)
	endif()
	
	if(NOT EXISTS "${cmd_exe}")
		dk_findProgram(cmd_exe "cmd.exe")
		file(TO_NATIVE_PATH "${cmd_exe}" cmd_exe)
	endif()


	### Test exists
	if(NOT EXISTS "${cmd_exe}") 
		dk_notice("cmd_exe:${cmd_exe} not found")
		return()
	endif()
	
	### Test command
	execute_process(COMMAND ${cmd_exe} /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(${exit_code})
		dk_notice("cmd_exe:${cmd_exe} failed to run")
		return()
	endif()

	dk_set(cmd_exe "${cmd_exe}")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(cmd_exe)
	
	dk_validate(cmd_exe "dk_depend(cmd_exe)")
	dk_echo("cmd_exe = ${cmd_exe}")
	
	dk_validate(cmd_exe "dk_depend(cmd_exe)")
	dk_echo("cmd_exe = ${cmd_exe}")
endfunction()	