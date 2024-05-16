@echo off
call DK

::#####################################################################
::# dk_getParentDir(<input> <output>)
::#
::#
:dk_getParentDir () {
	call dk_debugFunc
	if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	setlocal enableDelayedExpansion
	for %%A in (%1.) do set "parent=%%~dpA"
    endlocal & set "%2=%parent%"
goto:eof




:DKTEST ########################################################################
