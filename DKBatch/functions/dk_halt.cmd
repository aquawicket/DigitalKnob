@echo off
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_halt()
::#
::#
:dk_halt
setlocal
	%dk_call% dk_debugFunc 0

    call:HALT %NO_STDERR%
    :HALT
        %dk_call% dk_echo "%red%###### HALT ######%clr%"
        ()
%endfunction%

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_echo "calling dk_halt on next line"
    %dk_call% dk_halt
    %dk_call% dk_echo "this is the line after halt"
%endfunction%
