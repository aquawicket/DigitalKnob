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


#########################################################################
# dk_killProcess(name)
#
#	Kill a running process by name
#
#	@name		- name of the process to kill
#
function(dk_killProcess)
	dk_debugFunc(1 2)
	
	#set(name ${ARGV0})

	if(Windows_Host)
		dk_validate(taskkill_exe "dk_depend(taskkill_exe)")
		dk_exec(${taskkill_exe} /f /im "${ARGV0}")
		set(dk_killProcess ${dk_exec_exitcode} PARENT_SCOPE)
	endif()
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo("Opening mspaint.exe . . .")
	dk_exec(cmd /c start "mspaint.exe" TIMEOUT 0.5)
	dk_echo("waiting 3 seconds . . .")
	dk_sleep(3)
	dk_echo("Killing mspaint.exe . . .")
	dk_killProcess("mspaint.exe")
	dk_echo("dk_killProcess = ${dk_killProcess}")
endfunction()