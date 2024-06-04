@echo off
call DK

::################################################################################
::# dk_getFilename(<path> <rtn_var>)
::#
::#
:dk_getFilename () {
	call dk_debugFunc
	if %__ARGC__% neq 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal enabledelayedexpansion
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~nxZ"
	endlocal & call dk_set %2 "%OUT%"
goto:eof




:DKTEST ########################################################################

	call dk_getFilename "C:\Windows\System32\notepad.exe" filename
	echo filename = %filename%