@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_pickType()
::#
::#
:dk_pickType
 setlocal
    call dk_debugFunc 1

    %dk_call% dk_setTitle DigitalKnob - %APP% %TARGET_OS% %TYPE%
    %dk_call% dk_echo
    %dk_call% dk_echo "%APP% %TARGET_OS% %TYPE%"
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

    if "%choice%"=="1" set "%1=Debug"                & goto:eof
    if "%choice%"=="2" set "%1=Release"              & goto:eof
    if "%choice%"=="3" set "%1=All"                  & goto:eof
    if "%choice%"=="4" set "%1=none"                 & goto:eof
    if "%choice%"=="5" %dk_call% dk_clearScreen      & goto:eof
    if "%choice%"=="6" %dk_call% dk_unset TARGET_OS  & goto:eof
    if "%choice%"=="7" %dk_call% dk_exit             & goto:eof

    %dk_call% dk_echo %choice%: invalid selection, please try again
    %dk_call% dk_unset TYPE
 endlocal
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal

    %dk_call% dk_pickType
 endlocal
%endfunction%
