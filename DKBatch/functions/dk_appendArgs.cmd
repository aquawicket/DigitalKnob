@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

call dk_source dk_appendArgs
call dk_source dk_debugFunc
call dk_source dk_echo
call dk_source dk_error
::####################################################################
::# dk_appendArgs(variable, string)
::#
::#
:dk_appendArgs
	call dk_debugFunc
	if %__ARGC__% lss 2 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	for /f "tokens=1,* delims= " %%a in ("%*") do set ALL_BUT_FIRST=%%b
	
	if defined %~1 call set "%1=%%%~1%% %ALL_BUT_FIRST%"
	if not defined %~1 call set "%1=%ALL_BUT_FIRST%"
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_printVar myVar
	
	call dk_appendArgs myVar 123 abc
	call dk_printVar myVar
	
	call dk_appendArgs myVar 456 zyx
	call dk_printVar myVar
goto:eof
