@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"
if "%~1" equ "dk_keyboard.BeginReceiving" goto %1
if "%~1" equ "dk_keyboard.Keyboard_Loop" goto %1

::################################################################################
::# dk_keyboard()
::#
::#
:dk_keyboard
	::echo dk_keyboard %*
	
	if "%~1" == "callback" set callback=%~2 %~3
	::if defined callback echo callback = %callback%
	call dk_debugFunc 0 3 || %dk_call% dk_error "call dk_debugFunc failed!"
	
	rem Start Keyboard_Loop in a parallel process
	start "" /B cmd /C "%dk_call% dk_keyboard dk_keyboard.Keyboard_Loop" || echo Keyboard_Loop returned error
goto:eof

:dk_keyboard.Keyboard_Loop
	::echo dk_keyboard.Keyboard_Loop %*
	
	:: Read keys via PowerShell
	PowerShell  ^
	   Write-Host 0;  ^
	   while ($key -ne 27) {  ^
		  $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode;  ^
		  Write-Host $key  ^
	   }  ^
	%End PowerShell% | call "%~f0" dk_keyboard.BeginReceiving %2 || echo BeginReceiving retrned error
goto:eof

:dk_keyboard.BeginReceiving
	echo dk_keyboard.BeginReceiving %*
	
	:: Wait for Powershell code start signal
	set /P "keyCode="
	set /P "="
	
	:: enter keyboard polling loop
	call :dk_keyboard.pollKeys || %dk_call% dk_error "call :pollKeys failed!"
goto:eof
	
:dk_keyboard.pollKeys
	::echo dk_keyboard.pollKeys %*

	:: Process keys in Batch
	set /P "keyCode="
	set /P "="	
	
	if defined callback call %callback% %keyCode% || echo callback returned error && goto:eof
	::call :dk_keyboard.onKeyDown %keyCode% || %dk_call% dk_error "call :onKeyDown %keyCode% failed!"
	::if defined stopPollKeys goto:eof
	goto:dk_keyboard.pollKeys
goto:eof


:dk_keyboard.onKeyDown
	::echo dk_keyboard.onKeyDown %*
	
	set "keyCode=%1"
	echo keyCode = %keyCode%
	if %keyCode% equ 27 echo "Esc" && set "%2=1" && goto:eof
	
	if %keyCode% equ 13 echo "Enter"
	if %keyCode% equ 35 echo "End" 
	if %keyCode% equ 36 echo "Home" 
	if %keyCode% equ 37 echo "LeftArrow" 
	if %keyCode% equ 39 echo "RightArrow"
	set "keyCode="
goto:eof








::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0 || %dk_call% dk_error "call dk_debugFunc failed!"
	
	%dk_call% dk_keyboard || %dk_call% dk_error "%dk_call% dk_keyboard failed!"
	
	%dk_call% dk_echo "press escape to exit keyboard loop" || %dk_call% dk_error "%dk_call% dk_echo failed!"
goto:eof