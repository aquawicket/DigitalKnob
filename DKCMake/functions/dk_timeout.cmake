#!/usr/bin/cmake -P
if(NOT EXISTS "$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
	cmake_policy(SET CMP0009 NEW)
	file(GLOB_RECURSE DK.cmake "/DK.cmake")
	list(GET DK.cmake 0 DK.cmake)
	get_filename_component(DKCMAKE_FUNCTIONS_DIR "${DK.cmake}" DIRECTORY)
	set(ENV{DKCMAKE_FUNCTIONS_DIR_} "${DKCMAKE_FUNCTIONS_DIR}/")
endif()
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()


##############################################################################
# dk_timeout(seconds)
# 
#	Pause execution and wait for <enter> keypress to continue or amount of seconds to pass
#
function(dk_timeout) 
	dk_debugFunc(0 1)
	
	dk_getArg(0 seconds 10)
	
	if("${seconds}" STREQUAL "")
		set(seconds 10)
	endif()
	dk_assertVar(seconds)

	#if("${CMAKE_HOST_SYSTEM_NAME}" EQUAL "Windows")
	
	dk_DKSHELL()
	
	###### CMD ######
	if("${DKSHELL}" STREQUAL "CMD")
		dk_validate(CMD_EXE "dk_depend(cmd)")
		if(EXISTS "${CMD_EXE}")
			dk_validate(TIMEOUT_EXE "dk_TIMEOUT_EXE()")
			set(command "(${TIMEOUT_EXE} /t ${seconds})")
			message("\nCMD_EXE = ${CMD_EXE}")
			message("CMD> ${command}")
			execute_process(COMMAND "${CMD_EXE}" /c "${command}")
			return()
		endif()
	endif()
		
	###### POWERSHELL ######
	if("${DKSHELL}" STREQUAL "POWERSHELL")
		dk_validate(POWERSHELL_EXE "dk_depend(powershell)")
		if(EXISTS "${POWERSHELL_EXE}")
			set(command "Write-Host 'Waiting for ${seconds} seconds, press a key to continue ..'; $counter = 0; while(!$Host.UI.RawUI.KeyAvailable -and ($counter++ -lt ${seconds})){ [Threading.Thread]::Sleep(1000) }")
			message("\nPOWERSHELL_EXE = ${POWERSHELL_EXE}")
			message("POWERSHELL> ${command}")
			execute_process(COMMAND "${POWERSHELL_EXE}" -Command "${command}")
			return()
		endif()
	endif()
	
	###### BASH ######
	if("${DKSHELL}" STREQUAL "BASH")
		dk_validate(BASH_EXE "dk_depend(bash)")
		if(EXISTS "${BASH_EXE}")
			set(command "read -t ${seconds} -n 1 -s -r -p \"waiting ${seconds} seconds. Press any key to continue . . .\n\"")
			message("\nBASH_EXE = ${BASH_EXE}")
			message("BASH> ${command}")
			execute_process(COMMAND "${BASH_EXE}" -c ${command})
			return()
		endif()
	endif()
	
	###### SH ######
	if("${DKSHELL}" STREQUAL "SH")
		dk_validate(SH_EXE "dk_depend(sh)")
		if(SH_EXE)
			set(command "read -t ${seconds} -n 1 -s -r -p \"waiting ${seconds} seconds. Press any key to continue . . .\"")
			message("\nSH_EXE = ${SH_EXE}")
			message("SH> ${command}")
			execute_process(COMMAND "${SH_EXE}" -c ${command})
			return()
		endif()
	endif()
	
	dk_fatal("dk_pause() failed:  cant find CMD, BASH, SH OR POWERSHELL")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	
	dk_timeout()
	
	dk_timeout(0)
	
	dk_timeout(1)
	
	dk_timeout("2")
	
	#set(timeA)
	dk_timeout(${timeA})
	
	set(timeB 0)
	dk_timeout(${timeB})
	
	set(timeC 1)
	dk_timeout("${timeC}")
	
	set(timeD 2)
	dk_timeout(timeD)
	
	set(varE 3)
	set(timeE ${varE})
	dk_timeout(timeE)
	
	set(varF 4)
	set(timeF varF)
	dk_timeout(timeF)
	
endfunction()
