@echo off
call DK

::################################################################################
::# dk_exit()
::#
::#
:dk_exit () {
	call dk_debugFunc
	if "%*" neq "" call dk_error "%__FUNCTION__%(%*): too many arguments"
	
	::cmd /k & exit
	exit
goto:eof