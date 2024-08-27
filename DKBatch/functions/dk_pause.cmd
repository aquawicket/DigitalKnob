@if (@X) == (@Y) @end /*
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::##################################################################################
::# dk_pause(pause_msg)
::#
::#    Pause execution and wait for <enter> keypress to continue
::#
:dk_pause
 setlocal
	call dk_debugFunc 0 1
	
	if "%~1" equ "" (set "pause_msg=Press any key to continue...") else (set "pause_msg=%~1")
	if "%~1" neq " " %dk_call% dk_echo "%pause_msg%"
	pause >nul
goto:eof






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_pause
	%dk_call% dk_pause "Pause with a custom message"
	%dk_call% dk_pause "%red%Pause %green%with %blue%colorful %yellow%message%clr%"
	%dk_call% dk_echo  "Pause with no message"
	%dk_call% dk_pause " "
goto:eof
