@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_debugFunc
call dk_source dk_error
::####################################################################
::# dk_prependArgs(variable, string)
::#
::#
:dk_prependArgs
	call dk_debugFunc
	if %__ARGC__% lss 2 call dk_error "%__FUNCTION__%:%__ARGV__% not enough arguments"
	
	setlocal
	for /f "tokens=1,* delims= " %%a in ("%*") do set "ALL_BUT_FIRST=%%b"
	
	if defined %~1 endlocal & call set "%~1=%ALL_BUT_FIRST% %%%~1%% "
	if not defined %~1 endlocal & set "%~1=%ALL_BUT_FIRST%"
goto:eof




call dk_source dk_printVar
::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_printVar myVar
	
	call dk_prependArgs myVar abc 123
	call dk_printVar myVar
	
	call dk_prependArgs myVar xyz 789
	call dk_printVar myVar
goto:eof
