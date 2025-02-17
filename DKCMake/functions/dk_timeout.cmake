#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
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

	###### CMD ######
	dk_depend(cmd)
	if(CMD_EXE)
	#if(EXISTS "$ENV{COMSPEC}")
		dk_validate(CMD_EXE "dk_CMD_EXE()")
		dk_validate(TIMEOUT_EXE "dk_TIMEOUT_EXE()")
		execute_process(COMMAND "${CMD_EXE}" /c "(${TIMEOUT_EXE} /t ${seconds})")
		return()
	endif()
	
	###### POWERSHELL ######
	find_program(POWERSHELL_EXE powershell.exe)
	if(EXISTS ${POWERSHELL_EXE})
		execute_process(COMMAND ${POWERSHELL_EXE} -Command "Write-Host 'Waiting for ${seconds} seconds, press a key to continue ..'; $counter = 0; while(!$Host.UI.RawUI.KeyAvailable -and ($counter++ -lt ${seconds})){ [Threading.Thread]::Sleep(1000) }")
		return()
	endif()
	
	###### BASH ######
	execute_process(COMMAND bash -c "command -v 'bash'" OUTPUT_VARIABLE BASH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(BASH_EXE)
		execute_process(COMMAND ${BASH_EXE} -c "read -t ${seconds} -n 1 -s -r -p \"waiting ${seconds} seconds. Press any key to continue . . .\n\"")
		return()
	endif()
	
	###### SH ######
	execute_process(COMMAND sh -c "command -v 'sh'" OUTPUT_VARIABLE SH_EXE OUTPUT_STRIP_TRAILING_WHITESPACE)
	if(SH_EXE)			
		execute_process(COMMAND ${SH_EXE} -c "read -t ${seconds} -n 1 -s -r -p \"waiting ${seconds} seconds. Press any key to continue . . .\"")
		return()
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
