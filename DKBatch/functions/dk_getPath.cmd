@echo off
call DK

::################################################################################
::# dk_getPath(<path> <output>)
::#
::#    reference: https://stackoverflow.com/a/59739663/688352
::#
:dk_getPath () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	set _input=%1
	set _input=%_input:"=%
	if [%_input:~-1,1%] == [\] set _input=%_input:~0,-1%
	if [%_input:~-1,1%] == [/] set _input=%_input:~0,-1%
	for %%Z in ("%_input%") do set "OUT=%%~pZ"
	endlocal & set %2=%OUT:~0,-1%
goto:eof



:DKTEST ########################################################################
