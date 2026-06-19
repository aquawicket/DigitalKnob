@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


if /i "%~1" equ ":dk_keyboard.BeginReceiving" goto %1
if /i "%~1" equ ":dk_keyboard.Keyboard_Loop" goto %1

rem ################################################################################
rem # dk_keyboard()
rem #
rem #
:dk_keyboard
%setlocal%


    echo dk_keyboard %*
   
    if /i "%~1" equ "callback" set callback=%~2 %~3
    rem if defined callback echo callback = %callback%
   
    rem Start Keyboard_Loop in a parallel process
    start "" /B %ComSpec% /C "%dk_call% dk_keyboard :dk_keyboard.Keyboard_Loop" || echo Keyboard_Loop returned error
%endfunction%

:dk_keyboard.Keyboard_Loop
 rem %setlocal%
    rem echo dk_keyboard.Keyboard_Loop %*
   
    rem Read keys via PowerShell
    dk_evalPowershell ^
       Write-Host 0; ^
       while ($key -ne 27) { ^
          $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode; ^
          Write-Host $key ^
       } ^
    %End PowerShell% | call "%~f0" :dk_keyboard.BeginReceiving %2 || echo BeginReceiving retrned error
%endfunction%

:dk_keyboard.BeginReceiving
 rem %setlocal%

    echo dk_keyboard.BeginReceiving %*
   
    rem Wait for Powershell code start signal
    set /P "keyCode="
    set /P "="
   
    rem enter keyboard polling loop
    call :dk_keyboard.pollKeys || %dk_call% dk_error "call :pollKeys failed!"
%endfunction%
   
:dk_keyboard.pollKeys
 rem %setlocal%
    rem echo dk_keyboard.pollKeys %*

    rem Process keys in Batch
    set /P "keyCode="
    set /P "=" 
   
    if defined callback call %callback% %keyCode% || echo callback returned error && %return%
    rem if NOT defined callback call :dk_keyboard.onKeyDown %keyCode% || %dk_call% dk_error "call :onKeyDown %keyCode% failed!"
    rem if defined stopPollKeys %return%
    goto dk_keyboard.pollKeys
%endfunction%


:dk_keyboard.onKeyDown
 rem %setlocal%
    rem echo dk_keyboard.onKeyDown %*
   
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








rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
   
    dk_call dk_keyboard || %dk_call% dk_error "%%dk_call%% dk_keyboard failed!"
   
    %dk_call% dk_echo "press escape to exit keyboard loop" || %dk_call% dk_error "%%dk_call%% dk_echo failed!"
%endfunction%