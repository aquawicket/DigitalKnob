@echo off

if not defined exit (set exit=^
	call set buffer=%%errorlevel%% ^& ^
	call set prev_error=%%error_code%% ^& ^
	call set error_code=%%buffer%% ^& ^
	call set last_error=%%buffer%% ^& ^
	call set file=%%~nx0 ^& ^
	call set function=%%~0 ^& ^
	call set args=%%* ^& ^
	call echo EXIT %%file%% %%function%%^(%%args%%^) ^& ^
	call echo error_code = %%error_code%% ^& ^
	call echo prev_error = %%prev_error%% ^& ^
	call echo last_error = %%last_error%% ^& ^
	echo. ^& ^
	call exit /b %%error_code%%
)

::if "%RELOADED%" neq "1" (
::	call :dk_reload %*
::	%exit%
::)

::if "!DE!" neq "" (
::	echo ERROR: DKBatch requires delayed expansion
::	%exit%
::)

::if not defined clear_error	set "clear_error=(call )"
setlocal enableDelayedExpansion
(set exit=^
	set buffer=^^!errorlevel^^! ^&^
	set prev_error=^^!error_code^^! ^&^
	set error_code=^^!buffer^^! ^&^
	^(if "^!buffer^!" neq "0 " set last_error=^^!buffer^^!^) ^&^
	call set file=%%~nx0 ^&^
	call set function=%%~0 ^&^
	call set args=%%* ^&^
	echo EXIT ^^!file^^! ^^!function^^!^(^^!args^^!^) ^&^
	echo error_code = ^^!error_code^^! ^&^
	echo prev_error = ^^!prev_error^^! ^&^
	echo last_error = ^^!last_error^^! ^&^
	echo. ^&^
	exit /b ^^!error_code^^!
)


::################
goto:end_testA
:testA
	echo ######### testA(%*) #########
	%log%
	
	pause
	%exit%
:end_testA


::################
goto:end_testB
:testB
	echo ######### testB(%*) #########
	echo abc
	abc
	
	%exit%
:end_testB


::################
goto:end_testC
:testC
	echo ######### testC(%*) #########
	echo set /a "test=^!test^!
	set /a "test=^!test^!
	
	%exit%
:end_testC


::################
goto:end_testD
:testD
	echo ######### testD(%*) #########
	echo SET /A test=1/0
	set /A test=1/0
	
	%exit%
:end_testD



call :testA abc
call :testB 123
call :testC def
call :testD 456

pause