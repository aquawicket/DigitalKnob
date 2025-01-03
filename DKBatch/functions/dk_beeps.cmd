@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_beeps(array)
::#
::#  array(frequency, duration)
::#    frequency - The frequency of the beep, ranging from 37 to 32767 hertz.
::#		duration - The duration of the beep measured in milliseconds.
::#
:dk_beeps
::setlocal
	::%dk_call% dk_debugFunc 0 2
	
	set n=0
    :loop
    if defined %~1[!n!] (
		(set "song=!song!;[console]::beep(!%~1[%n%]!)")
        set /a n+=1
        goto loop 
    )
	
	::### Method 1 - powershell beep ###
	if not defined POWERSHELL_EXE (%dk_call% dk_POWERSHELL_EXE)
	"%POWERSHELL_EXE%" "%song%"

	::### Method 3 - echo BELL character ###
::	set "BELL="    &::contains a BELL 0x07 character
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
	
	%dk_call% Array::dk_push errorBeeps "200, 1400"
	%dk_call% Array::dk_push errorBeeps "200, 1400"
	%dk_call% Array::dk_push errorBeeps "200, 1400"
	%dk_call% Array::dk_push errorBeeps "200, 1400"
	%dk_call% Array::dk_push errorBeeps "200, 1400"
	
	::%dk_call% dk_printVar myBeeps
	%dk_call% dk_beeps errorBeeps

%endfunction%