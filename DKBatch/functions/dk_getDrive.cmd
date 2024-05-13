@echo off
call DK

::####################################################################
::# dk_getDrive(<path> <output>)
::#
::#
:dk_getDrive () {
	call dk_debugFunc
	
	setlocal enabledelayedexpansion
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~dZ"
	endlocal & set %2=%OUT%
goto:eof




:DKTEST ########################################################################
