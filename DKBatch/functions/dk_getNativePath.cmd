@echo off
call DK

::####################################################################
::# dk_getNativePath(<path> <output>)
::#
::#
:dk_getNativePath () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	setlocal enabledelayedexpansion
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~fZ"
	endlocal & set %2=%OUT%
goto:eof




:DKTEST ########################################################################

	call dk_getNativePath