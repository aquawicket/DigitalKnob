@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)



::#############
:A
	echo funcA
pause
exit /b 0

::#############
:B
	echo funcB
exit /b 0

::#############
:C
	echo funC
exit /b 0
	
pause

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal enableDelayedExpansion
	

	::echo|set /p=
	
	
	::for /f "usebackq tokens=*" %%i in (`date/time/t`) do (echo|set /p=## %%i ##)
	set $dk_date=for /f "usebackq tokens=*" %%i in (`date/time/t`) do (call:func abc %%i)

	::for /f "usebackq tokens=*" %%i in (`date/time/t`) do (call:func abc %%i)
	
	!$dk_date!
exit /b 0


:func arg1 arg2
	echo 1 = %~1
exit /b 0
