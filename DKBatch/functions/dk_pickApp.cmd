::@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#####################################################################
::# dk_pickApp(rtn_var)
::#
::#
:dk_pickApp APP
    call dk_debugFunc 0 1
 ::setlocal 
    
    %dk_call% dk_setTitle DigitalKnob - %APP% %TARGET_OS% %TYPE%
    
    %dk_call% dk_readCache _APP_ _TARGET_OS_ _TYPE_
	::%dk_call% dk_printVar _APP_
	::%dk_call% dk_printVar _TARGET_OS_
	::%dk_call% dk_printVar _TYPE_
	
    :: get a list of the directories in DKApps
    %dk_call% dk_getDirectories %DKAPPS_DIR% options
	::%dk_call% dk_printVar options
    
    :: rename the list elements to the folder basename and add a matching command
    set /a "n=0"
    :loop1
        if not defined options[%n%] goto:endloop1
        ::if "!DE!" neq "" for %%Z in ("%%%options%[%n%]%%") do set "options[%n%]=%%~nxZ"
        if "!DE!" equ "" for %%Z in ("!options[%n%]!") do set "options[%n%]=%%~nxZ"
        set "commands[%n%]=%dk_call% dk_set APP !options[%n%]!"
        set /a n+=1
        goto:loop1 
    :endloop1
    ::%dk_call% dk_printVar commands
	
    :: prepend cache selection if available
    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" neq "" if "%_TARGET_OS_%" neq "" if "%_TYPE_%" neq "" (
        %dk_call% dk_arrayUnshift options "re-run [%_APP_% - %_TARGET_OS_% - %_TYPE_%]"
        %dk_call% dk_arrayUnshift commands "call:runCache"
    )
    goto:end_runCache
    :runCache
        %dk_call% dk_info "re-running cached options..."
        %dk_call% dk_set APP %_APP_% & call dk_set TARGET_OS %_TARGET_OS_% & call dk_set TYPE %_TYPE_% & %return%
    :end_runCache
    
    :: append remaining options with commands
    %dk_call% dk_arrayPush options "Enter Manually"
    %dk_call% dk_arrayPush commands "%dk_call% dk_enterManually"
    
    %dk_call% dk_arrayPush options "Clear Screen"
    %dk_call% dk_arrayPush commands "%dk_call% dk_clearScreen"
    
    %dk_call% dk_arrayPush options "Reload"
    %dk_call% dk_arrayPush commands "%dk_call% dk_reload"
    
    %dk_call% dk_arrayPush options "Go Back"
    %dk_call% dk_arrayPush commands "%dk_call% dk_unset UPDATE"
    
    %dk_call% dk_arrayPush options "Exit"
    %dk_call% dk_arrayPush commands "%dk_call% dk_exit"

	::%dk_call% dk_printVar options
	::%dk_call% dk_printVar commands
	
    :: Print the options list
    set /a "n=0"
    :loop2
        if not defined options[%n%] goto:endloop2
        echo %n%: !options[%n%]!
        set /a n+=1
        goto:loop2 
    :endloop2
    
    %dk_call% dk_echo 
    %dk_call% dk_echo "Please select an app to build"
    
    %dk_call% dk_keyboardInput choice
    ::%dk_call% dk_keyboardInputTimeout choice 23 60 
    
    %dk_call% dk_echo "!options[%choice%]!"
    
    ::if "!DE!" equ "" %%%apps%[%n%]%% && %return%
    if not defined commands[%choice%] (
        %dk_call% dk_echo "%choice%: invalid selection, please try again"
        %dk_call% dk_unset APP
        %return%
    )
    
    if "!DE!" neq "" %dk_call% dk_error "delayed expansion is required"
    
    endlocal & !commands[%choice%]!
    if "%~1" neq "" endlocal & set "%1=%APP%"
    %dk_call% dk_deleteArray options
    %dk_call% dk_deleteArray commands
    %return%
    
    
::    %dk_call% dk_echo
::    if exist "%DKBRANCH_DIR%\cache" if "%_APP_%" neq "" if "%_TARGET_OS_%" neq "" if "%_TYPE_%" neq "" echo  0) Repeat cache [%_APP_% - %_TARGET_OS_% - %_TYPE_%]
::    echo  1) HelloWorld
::    echo  2) DKCore
::    echo  3) DKJavascript
::    echo  4) DKSDL
::    echo  5) DKSDLRml
::    echo  6) DKDomTest
::    echo  7) DKTestAll
::    echo  8) Enter Manually
::    echo  9) Clear Screen
::    echo 10) Reload
::    echo 11) Go Back
::    echo 12) Exit
    
::  %dk_call% dk_echo 
::    %dk_call% dk_echo "Please select an app to build"
::  %dk_call% dk_keyboardInput choice
::   if "%choice%"=="0"  %dk_call% dk_set APP %_APP_% & %dk_call% dk_set TARGET_OS %_TARGET_OS_% & %dk_call% dk_set TYPE %_TYPE_% & %return%
::    if "%choice%"=="1"  %dk_call% dk_set APP HelloWorld   & %return%
::    if "%choice%"=="2"  %dk_call% dk_set APP DKCore       & %return%
::    if "%choice%"=="3"  %dk_call% dk_set APP DKJavascript & %return%
::    if "%choice%"=="4"  %dk_call% dk_set APP DKSDL        & %return%
::    if "%choice%"=="5"  %dk_call% dk_set APP DKSDLRml     & %return%
::    if "%choice%"=="6"  %dk_call% dk_set APP DKDomTest    & %return%
::    if "%choice%"=="7"  %dk_call% dk_set APP DKTestAll    & %return%
::    if "%choice%"=="8"  %dk_call% dk_enterManually        & %return%
::    if "%choice%"=="9"  %dk_call% dk_clearScreen          & %return%
::    if "%choice%"=="10" %dk_call% dk_reload               & %return%
::    if "%choice%"=="11" %dk_call% dk_unset UPDATE         & %return%
::    if "%choice%"=="12" %dk_call% dk_exit                 & %return%
::
::    %dk_call% dk_echo "%choice%: invalid selection, please try again"
::    %dk_call% dk_unset APP
%endfunction%



::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
:: setlocal
    call dk_debugFunc 0

    %dk_call% dk_pickApp APP
	%dk_call% dk_echo "APP = %APP%"
%endfunction%
