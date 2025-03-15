@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

::################################################################################
::# dk_set(name, value...)
::#
::#
:dk_set
setlocal enableDelayedExpansion
::	%dk_call% dk_debugFunc 2 99
	echo dk_set %*

	set _name_=%~1
	set "_args_=%*"
	set "_args_=!_args_:*%~1 =!"

	set /a "_argc_=0"
	for %%Z in (%_args_%) do (
		set /a _argc_+=1
	)
	if %_argc_% equ 1 (
		for %%Z in (%_args_%) do set _args_=%%~Z
	)

	endlocal & (set "%~1=%_args_%")

	::%dk_call% dk_printVar %~1
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
