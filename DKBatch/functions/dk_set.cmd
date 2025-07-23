@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::if not defined dk_set_PRINT_VARIABLE (set "dk_set_PRINT_VARIABLE=0")
::################################################################################
::# dk_set(name, value...)
::#
::#
:dk_set
%setlocal%
	%dk_call% dk_debugFunc 2 99

	set "_var_=%~1"
	
	set dk_allButFirstArgs=%*
	for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do (
		set dk_allButFirstArgs=%%~b
	)
	
	endlocal & (
		set "%_var_%=%dk_allButFirstArgs%"
	)

	if "%dk_set_PRINT_VARIABLE%" equ "1" (
		%dk_call% dk_printVar %_var_%
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
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
	
	%dk_call% dk_set CMAKE "%USERPROFILE:\=/%/DigitalKnob/DKTools/cmake-3.29.5-windows-x86_64"
	echo CMAKE = %CMAKE%
	
	%dk_call% dk_set TEST_VAR "abc" "123" "d e f" "4 5 6"
	echo TEST_VAR = %TEST_VAR%
%endfunction%
