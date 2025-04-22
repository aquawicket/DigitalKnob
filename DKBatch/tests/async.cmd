@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


if not "%~1" equ "" goto %~1
:MAIN
setlocal
	echo Here I am in the MAIN thread
	start "" /B %COMSPEC% /D /C "%~f0" :ASYNC
	echo Here I am in the MAIN thread again
	endlocal
	
	call :loop
	echo at end of MAIN
	pause
exit /b 0

:loop
	echo main loop
	%dk_call% dk_sleep 1
goto :loop
exit /b 0

:ASYNC
setlocal
	echo Now I am in the ASYNC thread
	
	set /P REPLY="Press a key"
	echo you pressed %REPLY%
	::timeout /T 10
	endlocal

	echo at end of ASYNC
exit /b 0

echo ### SHOULD NOT GET HERE ###