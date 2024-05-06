@echo off
call DK

::################################################################################
::# dk_set(<name> <value>)
::#
::#
:dk_set () {
	::call dk_debugFunc
	::if "%~1" == "" call dk_error "dk_set(): parameter 1 invalid"
	::if "%~2" == "" call dk_error "dk_set(): parameter 1 invalid"
	
	set "%~1=%~2"
goto:eof