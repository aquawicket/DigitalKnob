@echo off
call DK

::################################################################################
::# dk_getUnquoted(<variable> <output>)
::#
::#
:dk_getUnquoted () {
	call dk_debugFunc
	
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~Z"
	endlocal & set %2=%OUT%
goto:eof