@echo off
call DK

::################################################################################
::# dk_arrayPush(<array> <index>)
::#
::#    reference: https://www.w3schools.com/js/js_array_methods.asp#mark_push
::#
:dk_arrayPush () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	if "%~2" equ "" call dk_error "%__FUNCTION__%(%*): argument 2 is invalid"
	if "%~3" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	call dk_todo "dk_arrayPush"
goto:eof




:DKTEST ########################################################################
