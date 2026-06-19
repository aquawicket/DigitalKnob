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


rem ################################################################################
rem # dk_beep(frequency, duration)
rem #
rem #	frequency - The frequency of the beep, ranging from 37 to 32767 hertz.
rem #		duration - The duration of the beep measured in milliseconds.
rem #
:dk_beep
rem %setlocal%

	rem ### Method 1 - powershell beep ###
	
	rem ### frequency
	if "%frequency%" equ "" (set frequency=%~1)
	if "%frequency%" equ "" (set frequency=500)
	
	rem ### duration
	if "%duration%" equ "" (set duration=%~1)
	if "%duration%" equ "" (set duration=500)
	
	%dk_call% powershell.exe "[console]::beep(%frequency%,%duration%)"
	rem %dk_call% dk_callDKPowershell dk_beep %frequency% %duration%
	
	rem ### Method 3 - echo BELL character ###
rem	set "BELL="	&rem contains a BELL 0x07 character
rem	echo %BELL%

	rem ### Method - create and echo BELL character ###
rem	for /f eol^=^%LF%%LF%^ delims^= %%A in (
rem	   'forfiles /p "%~dp0." /m "%~nx0" /c "cmd /c echo.0x07"'
rem	) do echo.%%A

%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	(set G#1=196)
	(set A2=220)
	(set A#2=233)
	(set B2=247)
	(set C2=262)
	(set C#2=277)
	(set D2=294)
	(set D#2=311)
	(set E2=330)
	(set F2=349)
	(set F#2=370)
	(set G2=392)
	(set G#2=415)
	(set A3=440)
	
	call :dk_beep %G#1% 500
	call :dk_beep %A2% 500
	call :dk_beep %A#2% 500
	call :dk_beep %B2% 500
	call :dk_beep %C2% 500
	call :dk_beep %C#2% 500
	call :dk_beep %D2% 500
	call :dk_beep %E2% 500
	call :dk_beep %F2% 500
	call :dk_beep %F#2% 500
	call :dk_beep %G2% 500
	call :dk_beep %G#2% 500
	call :dk_beep %A3% 500

%endfunction%