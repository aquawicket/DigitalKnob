<<<<<<< HEAD
@echo off
if not "%~1"=="" goto %~1
:MAIN
	setlocal
	echo Here I am in the MAIN thread
	start "" /B cmd /D /C "%~f0" :ASYNC
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


if not "%~1" equ "" goto %~1
:MAIN
setlocal
	echo Here I am in the MAIN thread
	start "" /B %ComSpec% /D /C "%~f0" :ASYNC
>>>>>>> Development
	echo Here I am in the MAIN thread again
	endlocal
	
	call :loop
	echo at end of MAIN
	pause
exit /b 0

<<<<<<< HEAD
:ASYNC
	setlocal
=======
:loop
	echo main loop
	%dk_call% dk_sleep 1
goto :loop
exit /b 0

:ASYNC
setlocal
>>>>>>> Development
	echo Now I am in the ASYNC thread
	
	set /P REPLY="Press a key"
	echo you pressed %REPLY%
	::timeout /T 10
	endlocal

	echo at end of ASYNC
exit /b 0

<<<<<<< HEAD
echo should not get here
=======
echo ### SHOULD NOT GET HERE ###
>>>>>>> Development
