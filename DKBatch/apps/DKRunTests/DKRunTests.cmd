@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR_ "%dk_call% dk_DKBRANCH_DIR"
%dk_call% dk_assertPath DKBATCH_FUNCTIONS_DIR_

:MAIN
%setlocal% 
	set "READY=1"
	
	%dk_call% dk_getFiles %DKBATCH_FUNCTIONS_DIR_%
	%dk_call% Array/dk_length dk_getFiles
	%dk_call% dk_echo "%dk_length% files"
	::%dk_call% dk_printVar dk_getFiles
	
	for /l %%x in (0, 1, %dk_length%) do (
		call :RUNTEST !dk_getFiles[%%x]!
	)
	
	::call :RUNTEST dk_debug
	::call :RUNTEST dk_info

	pause
exit /b 0


:RUNTEST
	::###### DKTEST MODE ######
	if not exist %~1 (exit /b 0)
	%dk_call% dk_fileContains "%~1" ":DKTEST" || exit /b 1
	echo(
	echo(%bg_magenta%%white%###### DKTEST MODE ###### %~nx1 ###### DKTEST MODE ######%clr%
	echo(
	call :DKTEST %~1
	echo(
	echo(%bg_magenta%%white%######## END TEST ####### %~nx1 ######## END TEST #######%clr%
	echo(
exit /b 0



:DKTEST
	if not defined READY (goto:MAIN)
	%~1
exit /b 0

