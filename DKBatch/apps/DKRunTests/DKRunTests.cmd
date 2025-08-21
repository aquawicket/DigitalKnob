@echo off&::###### DK.cmd #########################################################################################################################
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

if "%~1" neq "" (
	call %~1 %*
	exit /b 0
)
::#####################################
:MAIN
%setlocal% 
	call :DISABLE dk_callDKBash
	call :DISABLE dk_callDKJava
	call :DISABLE dk_callDKPowershell
	call :DISABLE dk_confirm
	call :DISABLE dk_contains
	call :DISABLE dk_containsCI
	call :DISABLE dk_createFunctionList
	call :DISABLE dk_crlfToLf
	call :DISABLE dk_deleteDigitalKnob
	call :DISABLE dk_dumpStack
	call :DISABLE dk_deleteEmptyDirs
	call :DISABLE dk_evalDKC
	call :DISABLE dk_enterManually
	call :DISABLE dk_evalDKCpp
	call :DISABLE dk_exit
	
	%dk_call% dk_validate DKBATCH_FUNCTIONS_DIR_ "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_getFiles %DKBATCH_FUNCTIONS_DIR_%
	%dk_call% Array/dk_length dk_getFiles
	
	::### Clear log.txt
	echo( > %~dp0/log.txt
	
	set "dk_log_ERROR_CALLBACK=call %~f0 :CALLBACK"
	set "dk_log_FATAL_CALLBACK=call %~f0 :CALLBACK"
	
	set "READY=1"
	for /l %%x in (0, 1, %dk_length%) do (
		call :RUNTEST !dk_getFiles[%%x]!
	)

	pause
exit /b 0

::#####################################
:DISABLE
	set "disabled=%disabled%;%~1;"
%endfunction%

::#####################################
:RUNTEST
%setlocal%
	::###### DKTEST MODE ######
	if "#!disabled:;%~n1;=!#" neq "#!disabled!#" (
		echo %yellow% ######### %~nx1 is disabled ######### %clr%
		exit /b 0
	)
	if NOT EXIST "%~1" (exit /b -1)
	%dk_call% dk_fileContains "%~1" ":DKTEST" || exit /b -1
	
	set "CURRENT_TEST_FILE=%~nx1"
	echo(>> 						%~dp0/log.txt
	echo ######### %~nx1 #########>> 		%~dp0/log.txt
	title TESTING ### %~nx1 ###
	echo(
	echo(%bg_magenta%%white%###### DKTEST MODE ###### %~nx1 ###### DKTEST MODE ######%clr%
	echo(
	call :DKTEST %~1 && (
		echo(        ### passed status:!errorlevel!>> 		%~dp0/log.txt
	) || (
		echo(        ### FAILED status:!errorlevel!>> 		%~dp0/log.txt
	)
	echo(
	echo(%bg_magenta%%white%######## END TEST ####### %~nx1 ######## END TEST #######%clr%
	echo(
exit /b 0

::#####################################
:DKTEST
::%setlocal%
	if NOT defined READY (goto:MAIN)
	%~1
exit /b !errorlevel!	


:CALLBACK
::%setlocal%
	::echo %red% CALLBACK(%*)
	echo(    %*>> 		%~dp0/log.txt
exit /b 0