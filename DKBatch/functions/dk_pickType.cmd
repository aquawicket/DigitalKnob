@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_pickType(rtn_var:target_type)
::#
::#
:dk_pickType
    call dk_debugFunc 0 1
 ::setlocal
 
    %dk_call% dk_title DigitalKnob - %target_app% %target_triple% %target_type%
    %dk_call% dk_echo
    %dk_call% dk_echo "%target_app% %target_triple% %target_type%"
    %dk_call% dk_echo
    echo 1) Debug
    echo 2) Release
    echo 3) All
    echo 4) none
    echo 5) Clear Screen
    echo 6) Go Back
    echo 7) Exit
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select a build type."
    
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout choice 1 60 

    if "%choice%"=="1" endlocal & set "%1=Debug"     && %return%
    if "%choice%"=="2" endlocal & set "%1=Release"   && %return%
    if "%choice%"=="3" endlocal & set "%1=All"       && %return%
    if "%choice%"=="4" endlocal & set "%1=none"      && %return%
    if "%choice%"=="5" %dk_call% dk_clearScreen      && %return%
    if "%choice%"=="6" %dk_call% dk_unset target_triple     && %return%
    if "%choice%"=="7" %dk_call% dk_exit             && %return%

    %dk_call% dk_echo %choice%: invalid selection, please try again
    %dk_call% dk_unset target_type
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal

    %dk_call% dk_pickType
%endfunction%
