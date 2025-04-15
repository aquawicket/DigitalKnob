#!/usr/bin/cmake -P
include("$ENV{DKCMAKE_FUNCTIONS_DIR_}DK.cmake")
include_guard()

###############################################################################
# dk_killProcess(name)
#
#	Kill a running process by name
#
#	@name		- name of the process to kill
#
function(dk_killProcess)
	dk_debugFunc(1)
	#set(name ${ARGV0})
	
	#dk_findProgram(TASKKILL_EXE taskkill.exe "C:/Windows/System32")
	#dk_exec("${TASKKILL_EXE} /f /im ${ARGV0}" NO_HALT)
	dk_callDKBatch("dk_killProcess" "${ARGV0}")
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)

	dk_echo("Opening mspaint.exe")
	#execute_process(COMMAND cmd /c mspaint.exe TIMEOUT 0.1)
	dk_exec(mspaint.exe TIMEOUT 0.1)
	dk_echo("waiting 3 seconds . . .")
	dk_sleep(3)
	dk_echo("killing process 'mspaint.exe' . . .")
	dk_killProcess("mspaint.exe")
endfunction()