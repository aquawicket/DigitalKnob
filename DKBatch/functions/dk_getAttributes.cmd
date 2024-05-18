@echo off
call DK

::################################################################################
::# dk_getAttributes(<path> <output>)
::#
:dk_getAttributes () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	setlocal enabledelayedexpansion
		set "_input_=%1"
		set "_input_=%_input_:"=%"
		if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
		if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
		for %%Z in ("%_input_%") do set "OUT=%%~aZ"
	endlocal & set "%2=%OUT%"
	call dk_printVar "%2"
goto:eof



:DKTEST ########################################################################
