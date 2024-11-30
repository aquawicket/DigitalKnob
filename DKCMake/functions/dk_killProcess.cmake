#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()

###############################################################################
# dk_killProcess(name)
#
#	Kill a running process by name
#
#	@name		- name of the process to kill
#
function(dk_killProcess)
	dk_debugFunc(1)
	#set(name ${ARGN})
	
	dk_findProgram(TASKKILL_EXE taskkill.exe "C:/Windows/System32")
	dk_executeProcess("${TASKKILL_EXE} /f /im ${ARGN}" NO_HALT)
endfunction()





###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc(0)
	
	dk_killProcess("todo")
endfunction()