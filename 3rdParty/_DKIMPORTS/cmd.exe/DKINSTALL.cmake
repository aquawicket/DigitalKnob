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



###### cmd.exe ##########################################################
#
function(DKINSTALL)
	dk_debugFunc(0 1)

	execute_process(COMMAND "${cmd.exe}" /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(NOT "${exit_code}" STREQUAL "0")
		dk_pathToNative("$ENV{cmd.exe}" cmd.exe)
	endif()
	
	execute_process(COMMAND "${cmd.exe}" /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(NOT "${exit_code}" STREQUAL "0")
		dk_pathToNative("$ENV{ComSpec}" cmd.exe)
	endif()

	execute_process(COMMAND "${cmd.exe}" /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(NOT "${exit_code}" STREQUAL "0")
		string(REPLACE "\\" "/" SystemRoot "$ENV{SystemRoot}")
		dk_pathToNative("${SystemRoot}/System32/cmd.exe" cmd.exe)
	endif()
	
	execute_process(COMMAND "${cmd.exe}" /c ver RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(NOT "${exit_code}" STREQUAL "0")
		dk_findFile("cmd.exe")
	endif()
	
	
	# test
	execute_process(COMMAND "${cmd.exe}" /c ver RESULT_VARIABLE exit_code)
	if(NOT "${exit_code}" STREQUAL "0")
		if(EXISTS "${cmd.exe}")
			dk_error("cmd.exe:'${cmd.exe}' FAILED")
		else()
			dk_error("cmd.exe:'${cmd.exe}' NOT FOUND")
		endif()
		return()
	endif()
	
	#return
	dk_set(cmd.exe "${cmd.exe}")
	#dk_debug("cmd.exe = ${cmd.exe}")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_unset(cmd.exe)
	dk_validate(cmd.exe "dk_depend(cmd.exe)")
	dk_debug("cmd.exe = ${cmd.exe}")
	
	dk_unset(cmd.exe)
	dk_validate(cmd.exe "dk_depend(cmd.exe)")
	dk_debug("cmd.exe = ${cmd.exe}")
endfunction()	