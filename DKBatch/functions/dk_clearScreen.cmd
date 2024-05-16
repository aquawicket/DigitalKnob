@echo off
call DK

::################################################################################
::# dk_clearScreen()
::#
::#
:dk_clearScreen () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    cls
goto:eof



:DKTEST ########################################################################
