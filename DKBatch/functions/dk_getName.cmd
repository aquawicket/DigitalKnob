@echo off
call DK

::################################################################################
::# dk_getName(<path> <output>)
::#
::#    reference: https://stackoverflow.com/a/59739663/688352
::#
:dk_getName () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal enabledelayedexpansion
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~nZ"
	endlocal & set %2=%OUT%
	call dk_printVar %2
goto:eof




:DKTEST ########################################################################

	call dk_getName C:\Windows\System32 name
	call dk_printVar name
	
	call dk_getName TEST nameb
	call dk_printVar nameb