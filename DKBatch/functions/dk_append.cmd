@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_append(variable, string)
::#
::#
:dk_append () {
	call dk_debugFunc
	if %__ARGC__% lss 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal enableDelayedExpansion
	if not defined %~1 call dk_error "1:%~1 is not defined"
	
	
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST=%%b   &:: all_but_first argument
	set "append=!%~1! !ALL_BUT_FIRST!"
	endlocal & set "%1=%append%"
goto:eof




:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	call dk_debugFunc
	
	set "myVar=123"
	call dk_echo "myVar = %myVar%"
	call dk_append myVar "abc"
	call dk_echo "myVar = %myVar%"
	call dk_append myVar "zyx"
	call dk_echo "myVar = %myVar%"
goto:eof