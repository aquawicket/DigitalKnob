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
	if(EXISTS "${wslpath_exe}")
		execute_process(COMMAND ${wslpath_exe} /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if(NOT ${exit_code})
			return()
		endif()
	endif()
	
	
	if(NOT EXISTS "${wslpath_exe}")
		#file(TO_NATIVE_PATH "$ENV{ComSpec}" wslpath_exe)
		dk_pathToNative("$ENV{ComSpec}" wslpath_exe)
	endif()
	
	if(NOT EXISTS "${wslpath_exe}")
		string(REPLACE "\\" "/" windir "$ENV{windir}")
		#file(TO_NATIVE_PATH "${windir}/System32/cmd.exe" wslpath_exe)
		dk_pathToNative("${windir}/System32/cmd.exe" wslpath_exe)
	endif()
	
	if(NOT EXISTS "${wslpath_exe}")
		dk_findProgram(wslpath_exe "cmd.exe")
		#file(TO_NATIVE_PATH "${wslpath_exe}" wslpath_exe)
		dk_pathToNative("${wslpath_exe}" wslpath_exe)
	endif()


	### Test exists
	if(NOT EXISTS "${wslpath_exe}") 
		dk_notice("wslpath_exe:${wslpath_exe} NOT FOUND")
		return()
	endif()
	
	### Test command
	execute_process(COMMAND ${wslpath_exe} /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(${exit_code})
		dk_notice("wslpath_exe:${wslpath_exe} failed to run")
		return()
	endif()

	dk_set(wslpath_exe "${wslpath_exe}")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(wslpath_exe)
	
	dk_validate(wslpath_exe "dk_depend(wslpath_exe)")
	dk_echo("wslpath_exe = ${wslpath_exe}")
	
	dk_validate(wslpath_exe "dk_depend(wslpath_exe)")
	dk_echo("wslpath_exe = ${wslpath_exe}")
endfunction()	