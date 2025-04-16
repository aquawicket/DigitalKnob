@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_set(name, value...)
::#
::#
:dk_set
setlocal enableDelayedExpansion
::	%dk_call% dk_debugFunc 2 99

	set _name_=%~1
	
	::set "_args_=%*"
	::set "_args_=!_args_:*%1=!"
	%dk_call% dk_allButFirstArgs %*
	
	set /a "_argc_=0"
	for %%Z in (%dk_allButFirstArgs%) do (
		set /a _argc_+=1
	)
	if "%_argc_%" equ "1" (
		for %%Z in (%dk_allButFirstArgs%) do set dk_allButFirstArgs=%%~Z
	)
	
	endlocal & (set "%~1=%dk_allButFirstArgs%")

	%dk_call% dk_printVar %~1 
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST 
setlocal
	%dk_call% dk_debugFunc 0

::	%dk_call% dk_set myVar word
::	echo myVar = %myVar%
::	%dk_call% dk_echo "myVar = %myVar%"
	
::  %dk_call% dk_set myVar "words in quotes"
::	echo myVar = %myVar%
::	%dk_call% dk_echo "myVar = %myVar%"
	
::	%dk_call% dk_set myVar words without quotes
::	echo myVar = %myVar%
::	%dk_call% dk_echo "myVar = %myVar%"

::	%dk_call% dk_set myVarB "dk_info('test dk_info message')"
::	echo myVar = %myVar%
::	%dk_call% dk_echo "myVarB = %myVarB%"
	
	%dk_call% dk_set CMAKE C:/Users/Administrator/digitalknob/DKTools/cmake-3.29.5-windows-x86_64
	echo CMAKE = %CMAKE%
%endfunction%
