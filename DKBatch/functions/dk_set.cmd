@echo off
call DK

::################################################################################
::# dk_set(name, value)
::#
::#
:dk_set () {
	call dk_debugFunc
	if %__ARGC__% lss 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	set "%~1=%~2"
	call dk_printVar "%~1"
goto:eof





:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_set myVar "value assigned with dk_set"
	call dk_echo "myVar = %myVar%"

goto:eof