@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::##################################################################################
::# dk_confirm()
::#
:dk_confirm
    %dk_call% dk_debugFunc 0
 setlocal
 
    set /P REPLY="%yellow% Are you sure ? [Y/N] %clr%"
    %dk_call% dk_echo
    %dk_call% dk_echo
    if /I "%REPLY%" equ "Y" (
        rem if "%~1" neq "" ( endlocal & %dk_call% dk_set %1 "true" )
        exit /b 0
    ) 
    
    rem if "%~1" neq "" ( endlocal & %dk_call% dk_set %1 "false" )
    exit /b 1
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    %dk_call% dk_debugFunc 0
 setlocal
 
    ::###### Using && and || conditionals
    %dk_call% dk_confirm && (echo "the confimation has passed") || (echo "the confimation has failed")
    
    ::###### abort in not confirmed type code
    %dk_call% dk_confirm || %return%
    echo "passed the confirmation, executing code after confirm"
%endfunction%
