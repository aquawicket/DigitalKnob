@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_source dk_debugFunc
call dk_source dk_error
::####################################################################
::# dk_prependArgs(variable, string)
::#
::#
:dk_prependArgs
	call dk_debugFunc 2 99
	
	setlocal
	for /f "tokens=1,* delims= " %%a in ("%*") do set "ALL_BUT_FIRST=%%b"
	
	if defined %~1 endlocal & call set "%~1=%ALL_BUT_FIRST% %%%~1%% "
	if not defined %~1 endlocal & set "%~1=%ALL_BUT_FIRST%"
goto:eof




call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_printVar myVar
	
	call dk_prependArgs myVar abc 123
	call dk_printVar myVar
	
	call dk_prependArgs myVar xyz 789
	call dk_printVar myVar
goto:eof
