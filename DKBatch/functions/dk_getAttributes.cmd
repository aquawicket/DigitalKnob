@echo off
call DK

::################################################################################
::# dk_getAttributes(<path> <output>)
::#
:dk_getAttributes () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	setlocal enabledelayedexpansion
		set "_input_=%1"
		set "_input_=%_input_:"=%"
		if [%_input_:~-1,1%] == [\] set "_input_=%_input_:~0,-1%"
		if [%_input_:~-1,1%] == [/] set "_input_=%_input_:~0,-1%"
		for %%Z in ("%_input_%") do set "OUT=%%~aZ"
	endlocal & set "%2=%OUT%"
goto:eof