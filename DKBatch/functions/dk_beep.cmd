@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_beep()
::#
::#
:dk_beep
    %dk_call% dk_debugFunc 0
 setlocal
 
	::### Method 1 - powershell beep ###
	%dk_call% dk_validate POWERSHELL_EXE "%dk_call% dk_POWERSHELL_EXE"
	"%POWERSHELL_EXE%" "[console]::beep(500,300)"

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
 
    %dk_call% dk_beep
%endfunction%