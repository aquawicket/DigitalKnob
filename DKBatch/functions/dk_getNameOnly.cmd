@echo off
call dk_includeGuard
call DK

::################################################################################
::# dk_getNameOnly(<path> <output>)
::#
::#    reference: https://stackoverflow.com/a/59739663/688352
::#
:dk_getNameOnly () {
	call dk_debugFunc
	
	setlocal enabledelayedexpansion
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~nZ"
	endlocal & set %2=%OUT%
goto:eof