@echo off
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../../../DKBatch/functions/")
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DKINIT_cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %* && exit /b %errorlevel%)



rem #############
:A
	echo funcA
pause
exit /b 0

rem #############
:B
	echo funcB
exit /b 0

rem #############
:C
	echo funC
exit /b 0
	
pause

rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
	

	rem echo|set /p=
	
	
	rem for /f "usebackq tokens=*" %%i in (`date/time/t`) do (echo|set /p=## %%i ##)
	set $dk_date=for /f "usebackq tokens=*" %%i in (`date/time/t`) do (call:func abc %%i)

	rem for /f "usebackq tokens=*" %%i in (`date/time/t`) do (call:func abc %%i)
	
	!$dk_date!
exit /b 0


:func arg1 arg2
	echo 1 = %~1
exit /b 0
