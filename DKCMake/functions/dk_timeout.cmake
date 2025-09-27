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


#########################################################################
# dk_timeout(seconds)
# 
#	Pause execution and wait for <enter> keypress to continue or amount of seconds to pass
#
function(dk_timeout) 
	dk_debugFunc(0 1)
	dk_getArg(0 seconds 10)
	
#	if("${seconds}" STREQUAL "")
#		dk_fatal("seconds:'${seconds}' is invalid")
#		set(seconds 10)
#	endif()
	dk_assertVar(seconds)

	dk_DKSHELL()
	
	###### CMD ######
	if(CMD_SHELL)
		dk_validate(timeout_exe "dk_depend(timeout_exe)")
		set(command "(${timeout_exe} /t ${seconds})")
		message("CMD> ${command}")
		execute_process(COMMAND "${cmd_exe}" /c "${command}")
		
	###### POWERSHELL ######
	elseif(POWERSHELL_SHELL)
		set(command "Write-Host 'Waiting for ${seconds} seconds, press a key to continue ..'; $counter = 0; while(!$Host.UI.RawUI.KeyAvailable -and ($counter++ -lt ${seconds})){ [Threading.Thread]::Sleep(1000) }")
		message("POWERSHELL> ${command}")
		execute_process(COMMAND "${powershell_exe}" -Command "${command}")
	
	###### BASH ######
	elseif(BASH_SHELL)
		set(command "read -t ${seconds} -n 1 -s -r -p \"waiting ${seconds} seconds. Press any key to continue . . .\n\"")
		message("BASH> ${command}")
		execute_process(COMMAND "${bash_exe}" -c ${command})
	
	###### SH ######
	elseif(SH_SHELL)
		set(command "read -t ${seconds} -n 1 -s -r -p \"waiting ${seconds} seconds. Press any key to continue . . .\"")
		message("SH> ${command}")
		execute_process(COMMAND "${sh_exe}" -c ${command})
	
	###### NOT FOUND ######
	else()
		dk_fatal("Could not find cmd, powershell, bash or sh")
	
	endif()
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	
	dk_timeout()
	
	dk_timeout(0)
	
	dk_timeout(1)
	
	dk_timeout(2)
	
	#set(timeA)
	dk_timeout(${timeA})
	
	set(timeB 0)
	dk_timeout(${timeB})
	
	set(timeC 1)
	dk_timeout(${timeC})
	
	set(timeD 2)
	dk_timeout(timeD)
	
	set(varE 3)
	set(timeE ${varE})
	dk_timeout(timeE)
	
	set(varF 4)
	set(timeF varF)
	dk_timeout(timeF)
	
endfunction()
