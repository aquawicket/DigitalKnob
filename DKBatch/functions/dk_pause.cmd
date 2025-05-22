@if (@X) == (@Y) @end /*
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::##################################################################################
::# dk_pause(pause_msg)
::#
::#    Pause execution and wait for <enter> keypress to continue
::#
:dk_pause
%setlocal%
    %dk_call% dk_debugFunc 0 1
   
    if "%~1" equ "" (set "pause_msg=Press any key to continue...") else (set "pause_msg=%~1")
    if "%~1" neq " " %dk_call% dk_echo "%pause_msg%"
    pause >nul
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
  
	%dk_call% dk_echo  "Pause with default message"
    %dk_call% dk_pause
    %dk_call% dk_pause "Pause with a custom message"
    %dk_call% dk_pause "%red%Pause %green%with %blue%colorful %yellow%message%clr%"
    %dk_call% dk_echo  "Pause with no message"
    %dk_call% dk_pause " "
%endfunction%
