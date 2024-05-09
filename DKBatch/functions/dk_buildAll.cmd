@echo off
call DK

::#################################################################################
:: dk_build()
::
::
:build_all () {
	call dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
goto:eof