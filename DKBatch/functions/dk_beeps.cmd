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
    ::%dk_call% dk_debugFunc 0 2
 ::setlocal
	(set array=%~1)
	::%dk_call% dk_printVar %array%
	
	set n=0
    :loop
    if defined %~1[!n!] (
		(set "song=!song!;[console]::beep(!%~1[%n%]!)")
        set /a n+=1
        goto loop 
    )
	echo song = %song%
	
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
    %dk_call% dk_debugFunc 0
 setlocal
	
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
	
	set "myBeeps[0]=%G#1%, 500"
	set "myBeeps[1]=%A2%, 500"
	set "myBeeps[2]=%A#2%, 500"
	set "myBeeps[3]=%B2%, 500"
	set "myBeeps[4]=%C2%, 500"
	set "myBeeps[5]=%C#2%, 500"
	set "myBeeps[6]=%D2%, 500"
	set "myBeeps[7]=%D#2%, 500"
	set "myBeeps[8]=%E2%, 500"
	set "myBeeps[9]=%F2%, 500"
	set "myBeeps[10]=%F#2%, 500"
	set "myBeeps[11]=%G2%, 500"
	set "myBeeps[12]=%G#2%, 500"
	set "myBeeps[13]=%A3%, 500"
	
	::%dk_call% dk_printVar myBeeps
	%dk_call% dk_beeps myBeeps

%endfunction%