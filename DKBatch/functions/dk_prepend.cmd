@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_prepend(variable, string)
::#
::#
:dk_prepend () {
	call dk_debugFunc
	if %__ARGC__% lss 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	setlocal enableDelayedExpansion
	for /f "tokens=1,* delims= " %%a in ("%*") do set "ALL_BUT_FIRST=%%b"   &:: all_but_first argument
	if defined %~1 set "prepend=!ALL_BUT_FIRST! !%~1!"
	if not defined %~1 set "prepend=!ALL_BUT_FIRST!"
	endlocal & set "%1=%prepend%"
	dk_printVar %1
goto:eof




:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	call dk_debugFunc
	
	call dk_echo "myVar = %myVar%"
	call dk_prepend myVar "abc"
	call dk_echo "myVar = %myVar%"
	call dk_prepend myVar "zyx"
	call dk_echo "myVar = %myVar%"
goto:eof