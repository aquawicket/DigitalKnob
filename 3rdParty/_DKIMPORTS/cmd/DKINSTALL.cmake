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



####################################################################
# DKINSTALL()
#
#
function(DKINSTALL)
	dk_debugFunc(0 1)

	### Test if already valid
	if(EXISTS "${cmd.exe}")
		execute_process(COMMAND ${cmd.exe} /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if(NOT ${exit_code})
			return()
		endif()
	endif()
	
	
	if(NOT EXISTS "${cmd.exe}")
		#file(TO_NATIVE_PATH "$ENV{ComSpec}" cmd.exe)
		dk_pathToNative("$ENV{ComSpec}" cmd.exe)
	endif()
	
	if(NOT EXISTS "${cmd.exe}")
		string(REPLACE "\\" "/" windir "$ENV{windir}")
		#file(TO_NATIVE_PATH "${windir}/System32/cmd.exe" cmd.exe)
		dk_pathToNative("${windir}/System32/cmd.exe" cmd.exe)
	endif()
	
	if(NOT EXISTS "${cmd.exe}")
		dk_findProgram(cmd.exe "cmd.exe")
		#file(TO_NATIVE_PATH "${cmd.exe}" cmd.exe)
		dk_pathToNative("${cmd.exe}" cmd.exe)
	endif()


	### Test exists
	if(NOT EXISTS "${cmd.exe}") 
		dk_notice("cmd.exe:${cmd.exe} NOT FOUND")
		return()
	endif()
	
	### Test command
	execute_process(COMMAND ${cmd.exe} /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(${exit_code})
		dk_notice("cmd.exe:${cmd.exe} failed to run")
		return()
	endif()

	dk_set(cmd.exe "${cmd.exe}")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(cmd.exe)
	
	dk_validate(cmd.exe "dk_depend(cmd.exe)")
	dk_debug("cmd.exe = ${cmd.exe}")
	
	dk_validate(cmd.exe "dk_depend(cmd.exe)")
	dk_debug("cmd.exe = ${cmd.exe}")
endfunction()	