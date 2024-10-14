#!/usr/bin/cmake -P
include(${DKCMAKE_FUNCTIONS_DIR_}DK.cmake)
#include_guard()


## We are looking for a good way to determin the path type we should use at any given moment in CMake.
## Say for example we are on a Windows box, using cmd, calling wsl.  Cmake will need /mnt/c/ type paths
## Or if Wsl invokes cmd.exe /c, that instance will require C:\ type paths. 
## The path type should corrolate to the current shell type. And when we are in CMake, we will 
## need to test the default shell type of execute_process to get the CMake subshell type.
## Another path problem then needs to be delt with is, when we are in a bash shell, how to translate 
## the home path properly at any location, and or be able to convert sais path to the desired type.
##
##    I.E. 
##
##		      UNIX =                          ${HOME}
##		   WINDOWS =					%USERPROFILE%
##			   cmd =				C:\Users\username 
##		  git bash =				/c/Users/username
##		msys2 bash =				/c/Users/username
##		  wsl bash =			/mnt/c/Users/username
##	   	linux bash =				   /home/username
##		MacOS bash =				  /Users/username
##	   termux bash = /data/data/com.termux/files/home
## 
## TEST: lets make a quick test the can be called from any shell, at any subshell level, and gets the correct path.
## Eventually we can expand on this class and add support for url's, xpaths, php, etc.
## Side note: maybe we can expand on dk_realpath to additionallu meet these requirements.

###############################################################################
# dk_getShellType(rtn_var)
#
#
function(dk_getShellType)
	#dk_debugFunc("\${ARGV}")
	
	execute_process(COMMAND cmd /c echo %COMSPEC% OUTPUT_VARIABLE CMD_PATH)
	message(STATUS "CMD_PATH = ${CMD_PATH}")
	
	execute_process(COMMAND powershell -c Write-Host "(Get-Process -Id $pid).Path" OUTPUT_VARIABLE POWERSHELL_PATH)
	message(STATUS "POWERSHELL_PATH = ${POWERSHELL_PATH}")
	
	execute_process(COMMAND sh -c "echo $0" OUTPUT_VARIABLE SH_PATH)
	message(STATUS "SH_PATH = ${SH_PATH}")
	
	execute_process(COMMAND bash -c "echo $0" OUTPUT_VARIABLE BASH_PATH)
	message(STATUS "BASH_PATH = ${BASH_PATH}")
	
#	dk_fileWrite(dkpstemp.cmake "message('CMAKE_COMMAND = ${CMAKE_COMMAND}')")
#	execute_process(COMMAND ${CMAKE_COMMAND} -p ${dkpstemp.cmake} OUTPUT_VARIABLE CMAKE_PATH)
#	message(STATUS "CMAKE_PATH = ${CMAKE_PATH}")
endfunction()






###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
function(DKTEST)
	dk_debugFunc("\${ARGV}")
	
	dk_getShellType(ShellType)
	#dk_printVar(ShellType)
endfunction()
