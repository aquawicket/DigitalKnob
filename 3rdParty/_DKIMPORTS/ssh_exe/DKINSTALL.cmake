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
# ssh_exe
#
#
function(DKINSTALL)
	dk_echo("########## ssh_exe DKINSTALL ###############")
	dk_debugFunc(0 1)
	
	### Test if already valid
	if(EXISTS "${ssh_exe}")
		execute_process(COMMAND ${ssh_exe} --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
		if(${exit_code} EQUAL 0)
			return()
		endif()
	endif()
	
	if(NOT EXISTS "${ssh_exe}")
		message("attempting 'dk_findProgram(ssh_exe \"curl.exe\")'")
		dk_findProgram(ssh_exe "curl.exe")
	endif()
	
	if(NOT EXISTS "${ssh_exe}")
		message("attempting 'bash -c \"command -v curl\"'")
		dk_validate(bash_exe "dk_depend(bash_exe)")
		message("bash_exe = ${bash_exe}")
		#dk_exec(bash -c "command -v curl")
		#set(ssh_exe "${dk_exec}")
		execute_process(COMMAND ${bash_exe} -c "command -v curl" OUTPUT_VARIABLE ssh_exe OUTPUT_STRIP_TRAILING_WHITESPACE)
	endif()
		
	if(NOT EXISTS "${ssh_exe}")
		message("attempting '${curl}/Windows_X86_64_Clang/Release/src/curl.exe'")
		dk_validate(curl "dk_depend(curl)")
		set(ssh_exe "${curl}/Windows_X86_64_Clang/Release/src/curl.exe")
	endif()
	
	if(NOT EXISTS "${ssh_exe}")
		message("attempting '${curl}/Windows_X86_Clang/Release/src/curl.exe'")
		dk_validate(curl "dk_depend(curl)")
		set(ssh_exe "${curl}/Windows_X86_Clang/Release/src/curl.exe")
	endif()

	if(NOT EXISTS "${ssh_exe}")
		message("attempting 'dk_pathToNative(${windir}/System32/curl.exe)'")
		string(REPLACE "\\" "/" windir "$ENV{windir}")
		dk_pathToNative("${windir}/System32/curl.exe" ssh_exe)
	endif()
	
	if(NOT EXISTS "${ssh_exe}")
		message("attempting 'dk_findProgram(ssh_exe \"curl.exe\")'")
		dk_findProgram(ssh_exe "curl.exe")
	endif()
	
	if(NOT EXISTS "${ssh_exe}")
		message("attempting 'dk_findProgram(ssh_exe \"curl\")'")
		dk_findProgram(ssh_exe "curl")
	endif()

	if(NOT EXISTS "${ssh_exe}")
		message("attempting 'set(ssh_exe \"curl.exe\")'")
		set(ssh_exe "curl.exe")
	endif()
	
	if(NOT EXISTS "${ssh_exe}")
		message("attempting 'set(ssh_exe \"curl\")'")
		set(ssh_exe "curl")
	endif()

	### Test exists
	if(NOT EXISTS "${ssh_exe}") 
		dk_error("ssh_exe:'${ssh_exe}' NOT FOUND")
		return()
	endif()
	
	### Test command
	execute_process(COMMAND "${ssh_exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(NOT ${exit_code} EQUAL 0)
		dk_error("ssh_exe:'${ssh_exe}' failed to run")
		return()
	endif()

	### firewall allow ###
	dk_firewallAllow("${ssh_exe}")

	###### return ######
	dk_set(ssh_exe "${ssh_exe}")
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_envList(PLUGIN POP)
	dk_unset(ssh_exe)
	
	dk_validate(ssh_exe "dk_depend(ssh_exe)")
	dk_debug("ssh_exe = ${ssh_exe}")
	
	dk_validate(ssh_exe "dk_depend(ssh_exe)")
	dk_debug("ssh_exe = ${ssh_exe}")
endfunction()	