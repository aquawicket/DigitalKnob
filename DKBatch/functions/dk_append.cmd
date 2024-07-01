@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::####################################################################
::# dk_append(variable, string)
::#
::#
:dk_append () {
	call dk_debugFunc
	if %__ARGC__% lss 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST=%%b
	call set %1=%%%~1%% "%ALL_BUT_FIRST%"
	call echo %1 = %%%1%%
	dk_printVar %1
goto:eof




:DKTEST () { ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
	call dk_debugFunc
	
	call dk_echo "myVar = %myVar%"
	call dk_append myVar "abc"
	call dk_echo "myVar = %myVar%"
	call dk_append myVar "zyx"
	call dk_echo "myVar = %myVar%"
goto:eof