@echo off
call DK

::################################################################################
::# dk_set(<name> <value>)
::#
::#
:dk_set () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	set "%~1=%~2"
goto:eof