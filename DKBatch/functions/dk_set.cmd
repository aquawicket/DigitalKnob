@echo off
call DK

::################################################################################
::# dk_set(<name> <value>)
::#
::#
:dk_set () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	
	set "%~1=%~2"
goto:eof