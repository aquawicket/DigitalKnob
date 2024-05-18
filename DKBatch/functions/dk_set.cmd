@echo off
call DK

::################################################################################
::# dk_set(<name> <value>)
::#
::#
:dk_set () {
	set OLD_ENABLE_dk_debugFunc=%ENABLE_dk_debugFunc%
	set ENABLE_dk_debugFunc=0
	call dk_debugFunc
	set ENABLE_dk_debugFunc=%OLD_ENABLE_dk_debugFunc%
	if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	set "%~1=%~2"
	dk_printVar %1
goto:eof





:DKTEST ########################################################################

	call dk_set myVar "value assigned with dk_set"
	echo myVar = %myVar%
