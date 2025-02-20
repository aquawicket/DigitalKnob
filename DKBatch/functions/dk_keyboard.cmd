@echo off
::echo dk_keyboard.cmd()
::echo 0 = %~0
::echo 1 = %~1
::echo 2 = %~2
::echo 3 - %~3

if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
if "%~1" equ ":dk_keyboard.BeginReceiving" goto %1
if "%~1" equ ":dk_keyboard.Keyboard_Loop" goto %1

::################################################################################
::# dk_keyboard()
::#
::#
:dk_keyboard
setlocal
    ::%dk_call% dk_debugFunc 0

 
    echo dk_keyboard %*
    
    if "%~1" == "callback" set callback=%~2 %~3
    ::if defined callback echo callback = %callback%
    %dk_call% dk_debugFunc 0 3 || %dk_call% dk_error "%dk_call% dk_debugFunc failed!"
    
    rem Start Keyboard_Loop in a parallel process
    start "" /B %COMSPEC% /C "%dk_call% dk_keyboard :dk_keyboard.Keyboard_Loop" || echo Keyboard_Loop returned error
%endfunction%

:dk_keyboard.Keyboard_Loop
    ::%dk_call% dk_debugFunc 0
 ::setlocal
    ::echo dk_keyboard.Keyboard_Loop %*
    
    :: Read keys via PowerShell
    dk_powershell ^
       Write-Host 0; ^
       while ($key -ne 27) { ^
          $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode; ^
          Write-Host $key ^
       } ^
    %End PowerShell% | call "%~f0" :dk_keyboard.BeginReceiving %2 || echo BeginReceiving retrned error
%endfunction%

:dk_keyboard.BeginReceiving
    ::%dk_call% dk_debugFunc 0
 ::setlocal
 
    echo dk_keyboard.BeginReceiving %*
    
    :: Wait for Powershell code start signal
    set /P "keyCode="
    set /P "="
    
    :: enter keyboard polling loop
    call :dk_keyboard.pollKeys || %dk_call% dk_error "call :pollKeys failed!"
%endfunction%
    
:dk_keyboard.pollKeys
    ::%dk_call% dk_debugFunc 0
 ::setlocal
    ::echo dk_keyboard.pollKeys %*

    :: Process keys in Batch
    set /P "keyCode="
    set /P "="  
    
    if defined callback call %callback% %keyCode% || echo callback returned error && %return%
    ::if not defined callback call :dk_keyboard.onKeyDown %keyCode% || %dk_call% dk_error "call :onKeyDown %keyCode% failed!"
    ::if defined stopPollKeys %return%
    goto dk_keyboard.pollKeys
%endfunction%


:dk_keyboard.onKeyDown
    %dk_call% dk_debugFunc 0
 ::setlocal
    ::echo dk_keyboard.onKeyDown %*
    
    set "keyCode=%1"
    echo keyCode = %keyCode%
    if %keyCode% equ 27 echo "Esc" && set "%2=1" && %return%
    
    if %keyCode% equ 13 echo "Enter"
    if %keyCode% equ 35 echo "End" 
    if %keyCode% equ 36 echo "Home" 
    if %keyCode% equ 37 echo "LeftArrow" 
    if %keyCode% equ 39 echo "RightArrow"
    set "keyCode="
%endfunction%








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
    ::%dk_call% dk_debugFunc 0

 
    %dk_call% dk_debugFunc 0 || %dk_call% dk_error "%dk_call% dk_debugFunc failed!"
    
    dk_call dk_keyboard || %dk_call% dk_error "%dk_call% dk_keyboard failed!"
    
    %dk_call% dk_echo "press escape to exit keyboard loop" || %dk_call% dk_error "%dk_call% dk_echo failed!"
%endfunction%