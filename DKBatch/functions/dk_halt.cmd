@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_halt()
::#
::#
:dk_halt
    call dk_debugFunc 0
 setlocal
 
    call:HALT %NO_STDERR%
    :HALT
        %dk_call% dk_echo "%red%###### HALT ######%clr%"
        ()
%endfunction%

::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_echo "calling dk_halt on next line"
    %dk_call% dk_halt
    %dk_call% dk_echo "this is the line after halt"
%endfunction%
