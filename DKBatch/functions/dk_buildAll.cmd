@echo off
call DK

::#################################################################################
:: dk_build()
::
::
:build_all () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
goto:eof



:DKTEST ########################################################################
