@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::#################################################################################
::# dk_getParameterValue(NAME)
::#
:dk_getParameterValue
%setlocal%
	%dk_call% dk_debugFunc 0 99

    :getParameter_loop
	if "%~1" equ "%~2" (
		if "%~3" equ "" (set "_value_=1")
		if "%~3" neq "" (set "_value_=%~3")
		goto end_getParameter_loop
	)
	if "%~3" neq "" (
		shift /2
		goto getParameter_loop
	)
	:end_getParameter_loop

    endlocal & (
		set "%~1=%_value_%"
	)
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	call :TEST_getParameter ARG1 "arg1 data" ARG3 ARG4 "arg4 data" ARG5 "arg5 data" ARG6
%endfunction%


:TEST_getParameter ARG1 ARG2 ARG3 ARG4 ARG5 ARG6 ARG7 ARG8 ARG9 ...
%setlocal%
	%dk_call% dk_debugFunc 0 99

	%dk_call% dk_getParameterValue ARG1 %*
	%dk_call% dk_getParameterValue ARG2 %*
	%dk_call% dk_getParameterValue ARG3 %*
	%dk_call% dk_getParameterValue ARG4 %*
	%dk_call% dk_getParameterValue ARG5 %*
	%dk_call% dk_getParameterValue ARG6 %*
	%dk_call% dk_echo "ARG1 = %ARG1%"
	%dk_call% dk_echo "ARG2 = %ARG2%"
	%dk_call% dk_echo "ARG3 = %ARG3%"
	%dk_call% dk_echo "ARG4 = %ARG4%"
	%dk_call% dk_echo "ARG5 = %ARG5%"
	%dk_call% dk_echo "ARG6 = %ARG6%"
	
%endfunction%