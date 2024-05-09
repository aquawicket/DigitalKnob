@echo off
call DK

::################################################################################
::# dk_clearScreen()
::#
::#
:dk_clearScreen () {
	call dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
    cls
goto:eof