@echo off
call DK

::#####################################################################
::# dk_getParentDir(<input> <output>)
::#
::#
:dk_getParentDir () {
	call dk_debugFunc
	
	setlocal enableDelayedExpansion
	for %%A in (%1.) do set "parent=%%~dpA"
    endlocal & set "%2=%parent%"
goto:eof




:DKTEST ########################################################################
