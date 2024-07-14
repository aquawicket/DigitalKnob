@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_realpath(path, rtn_var)
::#
::#    SHELL: https://man7.org/linux/man-pages/man1/realpath.1.html
::#
:dk_realpath
	call dk_debugFunc
	if %__ARGC__% neq 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	setlocal enabledelayedexpansion
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "_realpath_=%%~fZ"
	endlocal & call dk_set %2 "%_realpath_%"
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_realpath "DK.cmd" realpath
	call dk_echo "realpath = %realpath%"
goto:eof