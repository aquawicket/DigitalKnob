@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_beep(frequency, duration)
::#
::#	frequency - The frequency of the beep, ranging from 37 to 32767 hertz.
::#		duration - The duration of the beep measured in milliseconds.
::#
:dk_beep
::setlocal
	::%dk_call% dk_debugFunc 0 2
 
	::### Method 1 - powershell beep ###
	if not defined POWERSHELL_EXE (%dk_call% dk_POWERSHELL_EXE)
	if "%~1" equ "" (set frequency=500) else (set frequency=%~1)
	if "%~2" equ "" (set duration=500)  else (set duration=%~1)
	"%POWERSHELL_EXE%" "[console]::beep(%frequency%,%duration%)"
	::%dk_call% dk_callDKPowershell dk_beep %frequency% %duration%
	
	::### Method 3 - echo BELL character ###
::	set "BELL="	&::contains a BELL 0x07 character
::	echo %BELL%

	::### Method - create and echo BELL character ###
::	for /f eol^=^%LF%%LF%^ delims^= %%A in (
::	   'forfiles /p "%~dp0." /m "%~nx0" /c "cmd /c echo(0x07"'
::	) do echo(%%A

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
	
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
	
	if not defined POWERSHELL_EXE (%dk_call% dk_POWERSHELL_EXE)
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