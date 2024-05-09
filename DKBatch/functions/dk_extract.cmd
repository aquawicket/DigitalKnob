@echo off
call DK

::####################################################################
::# dk_extract(<file> <destination>)
::#
::#
:dk_extract () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	call dk_info "Extracting %~1 to %~2 . . ."
	if not exist "%~1"   call dk_error "cannot find %~1"
    powershell Expand-Archive "%~1" -DestinationPath "%~2"
goto:eof