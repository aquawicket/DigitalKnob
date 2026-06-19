@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


if "%~1" neq "" goto %~1
:MAIN
setlocal
	echo Here I am in the MAIN thread
	start "" /B %ComSpec% /D /C "%~f0" :ASYNC
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