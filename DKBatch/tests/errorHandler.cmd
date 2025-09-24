@echo off
set "DelayedExpansion=0"

::if NOT EXIST "%~f1" echo ERROR: DK.cmd must be called with %%~0 %%*. I.E.  "DK.cmd" %%~0 %%* & pause & exit 1
if NOT defined argv (set argv=%*)
if NOT defined argv (set argv=%~f0)

if "%DelayedExpansion%" equ "1" (
	if NOT defined RELOADED (
		echo "reloading with delayed expansion"
		set "RELOADED=1"
		cls
		"%ComSpec%" /A /Q /D /E:ON /V:ON /C %argv%		&rem | %DKBATCH_FUNCTIONS_DIR_%dk_tee.cmd %DKSCRIPT_NAME%.log
		exit /b %errorlevel%
		echo ### ERROR: SHOULD NOT GET HERE ### & pause
	)

	if "!DE!" neq "" (
		echo ### ERROR: DKBatch requires delayed expansion ### & pause
		exit /b %errorlevel%
		echo ### ERROR: SHOULD NOT GET HERE ### & pause
	)
)

if not defined DK.cmd (set "DK.cmd=1") else (exit /b %errorlevel%)

rem ###### delayed expansion OFF ######
if "!DE!" neq "" (
	title delayedExpansion OFF
	if NOT defined exit (
		set exit=^
		call set err_level=%%errorlevel%% ^& ^
		call set prev_error=%%error_code%% ^& ^
		call set error_code=%%err_level%% ^& ^
		call set last_error=%%err_level%% ^& ^
		call set file=%%~nx0 ^& ^
		call set function=%%~0 ^& ^
		call set args=%%* ^& ^
		call echo EXIT %%file%% %%function%%^(%%args%%^) ^& ^
		call echo error_code = %%error_code%% ^& ^
		call echo prev_error = %%prev_error%% ^& ^
		call echo last_error = %%last_error%% ^& ^
		echo. ^& ^
		call exit /b %%error_code%%)
	if not defined endfunction 	(call set "endfunction=%%exit%%")
	if not defined return 		(call set "return=%%exit%%")
	if not defined setlocal		(set setlocal=setlocal)
	
rem ###### delayed expansion ON ######
) else (
	title delayedExpansion ON
	if NOT defined exit (
		set exit=^
		set err_level=^^!errorlevel^^! ^&^
		set prev_error=^^!error_code^^! ^&^
		set error_code=^^!err_level^^! ^&^
		^(if "^!err_level^!" neq "0 " set last_error=^^!err_level^^!^) ^&^
		call set file=%%~nx0 ^&^
		call set function=%%~0 ^&^
		call set args=%%* ^&^
		echo EXIT ^^!file^^! ^^!function^^!^(^^!args^^!^) ^&^
		echo error_code = ^^!error_code^^! ^&^
		echo prev_error = ^^!prev_error^^! ^&^
		echo last_error = ^^!last_error^^! ^&^
		echo. ^&^
		exit /b ^^!error_code^^!)
	if not defined endfunction 	(set endfunction=!exit!)
	if not defined return 		(set return=!exit!)
	if not defined setlocal		(set setlocal=setlocal EnableDelayedExpansion)
)
if not defined pushStack	(set pushStack=call :pushStack %%~n0%%~0 %%*)
if NOT defined NO_STDOUT 	(set NO_STDOUT=1>nul)
if NOT defined NO_STDERR 	(set NO_STDERR=2>nul)
if NOT defined NO_OUTPUT 	(set NO_OUTPUT=1>nul 2>nul)
if not defined true 		(set true=0)
if not defined false 		(set false=1)


call :main
pause
%exit%

::################
:main
	call :testA abc
	call :testB 123
	call :testC def
	call :testD 456
%endfunction%

::################
:testA
	echo ######### testA(%*) #########
	%log%
%endfunction%


::################
:testB
	echo ######### testB(%*) #########
	echo abc
	abc
%endfunction%


::################
:testC
	echo ######### testC(%*) #########
	echo set /a "test=^!test^!
	set /a "test=^!test^!
%endfunction%


::################
:testD
	echo ######### testD(%*) #########
	echo SET /A test=1/0
	set /A test=1/0
%endfunction%

