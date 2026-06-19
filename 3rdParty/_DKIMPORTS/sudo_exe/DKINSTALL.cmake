#!/usr/bin/cmake -P
### DK.cmake ############################################################
if(NOT DEFINED DKINIT_cmake)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "/mnt/c/Users/Administrator/DigitalKnob/Development/DKCMake/functions/")
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
	message("sudo_exe:DKINSTALL.cmake")
	dk_debugFunc(0 1)
	
	### Test Defined / Exists / Executes
	if(DEFINED sudo_exe)
		if(EXISTS "${sudo_exe}")
			execute_process(COMMAND "${sudo_exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
			if(${exit_code} EQUAL 0)
				return()
			else()
				dk_unset(sudo_exe)
			endif()
		endif()
	endif()
	
	if(NOT DEFINED sudo_exe)
		dk_findProgram(sudo_exe "sudo")
	endif()

	### Test defined
	if(NOT DEFINED sudo_exe)
		dk_error("sudo_exe:${sudo_exe} NOT DEFINED")
		return()
	endif()
	
	### Test exists
	if(NOT EXISTS "${sudo_exe}")
		dk_error("sudo_exe:${sudo_exe} NOT FOUND")
		return()
	endif()
	
	### Test command
	execute_process(COMMAND "${sudo_exe}" --version RESULT_VARIABLE exit_code OUTPUT_QUIET)
	if(NOT ${exit_code} EQUAL 0)
		dk_error("sudo_exe:${sudo_exe} failed to run")
		return()
	endif()


	#d_k_get(DKSudo_pass)
	if(DEFINED DKSudo_pass)
		dk_debug("DKSudo_pass = ${DKSudo_pass}")
	else()
		dk_notice("DKSudo_pass is invalid")
	endif()
	if(DEFINED ENV{DKSudo_pass})
		dk_debug("ENV{DKSudo_pass} = $ENV{DKSudo_pass}")
	else()
		dk_notice("ENV{DKSudo_pass} is invalid")
	endif()
	if(DEFINED CACHE{DKSudo_pass})
		dk_debug("CACHE{DKSudo_pass} = $CACHE{DKSudo_pass}")
	else()
		dk_notice("CACHE{DKSudo_pass} is invalid")
	endif()
	
	
	### DKSudo_pass
	if(DEFINED DKSudo_pass)
		dk_debug("DKSudo_pass = ${DKSudo_pass}")
		### cmd.exe
		#[ ! command -v '${cmd.exe}' >/dev/null 2>&1 ] && export cmd.exe=$(command -v "cmd.exe") || return $?; 				# Test exist
		#[ "${cmd.exe-}" /c ver >/dev/null 2>&1 ] || { dk_call dk_error "cmd.exe:${cmd.exe-} failed to run"; return $?; }	
		#export DKSudo_pass=$(${cmd.exe} /c echo %DKSudo_pass% | tr -d '\r'); 												# Test Execute
		
		#dk_exec(builtin echo ${DKSudo_pass} | tr -d '\r')		
		#dk_set(DKSudo_pass ${dk_exec})
		
		dk_debug("DKSudo_pass = ${DKSudo_pass}")
		dk_set(sudo_exe "builtin echo ${DKSudo_pass}|& ${sudo} --stdin")
	endif()
	
	dk_set(sudo_exe "${sudo_exe}")  # Globalize
endfunction()








###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_validate(sudo_exe "dk_depend(sudo_exe)")
	dk_debug("sudo_exe = ${sudo_exe}")
	
	dk_validate(sudo_exe "dk_depend(sudo_exe)")
	dk_debug("sudo_exe = ${sudo_exe}")
	
	execute_process(COMMAND "${sudo_exe}" --version COMMAND_ECHO STDOUT OUTPUT_VARIABLE output ECHO_OUTPUT_VARIABLE)
	
endfunction()	