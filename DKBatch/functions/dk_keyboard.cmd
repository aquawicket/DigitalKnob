@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd
if "%~1" equ "BeginReceiving" goto %1
if "%~1" equ "Keyboard_Loop" goto %1

::################################################################################
::# dk_keyboard()
::#
::#
:dk_keyboard
	call dk_debugFunc || call dk_error "call dk_debugFunc failed!"
	if %__ARGC__% gtr 1 call dk_error "%__FUNCTION__%:%__ARGV__% too many arguments"
	
	rem Start Keyboard_Loop in a parallel process
	start "" /B cmd /C "call dk_keyboard Keyboard_Loop" || call dk_error "call dk_keyboard Keyboard_Loop failed!"
goto:eof

:Keyboard_Loop
	:: Read keys via PowerShell
	PowerShell  ^
	   Write-Host 0;  ^
	   while ($key -ne 27) {  ^
		  $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode;  ^
		  Write-Host $key  ^
	   }  ^
	%End PowerShell% | call "%~f0" BeginReceiving %2 || call dk_error "call "%~f0" BeginReceiving %2 failed!"
goto:eof

:BeginReceiving
	:: Wait for Powershell code start signal
	set /P "keyCode="
	set /P "="
	
	:: enter keyboard polling loop
	call :pollKeys || call dk_error "call :pollKeys failed!"
goto:eof
	
:pollKeys
	:: Process keys in Batch
	set /P "keyCode="
	set /P "="	
	call :onKeyDown %keyCode% stopPollKeys || call dk_error "call :onKeyDown %keyCode% failed!"
	rem for /F %%a in ('copy /Z "%~F0" NUL') do set "CR=%%a"
	rem for /F %%a in ('echo prompt $H ^| cmd') do set "BS=%%a"
	if defined stopPollKeys goto:eof
	goto:pollKeys
goto:eof


:onKeyDown
	set "keyCode=%1"
	echo keyCode = %keyCode%
	if %keyCode% equ 27 echo "Esc" && set "%2=1" && goto:eof
	
	if %keyCode% equ 13 echo "Enter"
	if %keyCode% equ 35 echo "End" 
	if %keyCode% equ 36 echo "Home" 
	if %keyCode% equ 37 echo "LeftArrow" 
	if %keyCode% equ 39 echo "RightArrow"
goto:eof








::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc || call dk_error "call dk_debugFunc failed!"
	
	call dk_keyboard || call dk_error "call dk_keyboard failed!"
	
	call dk_echo "press escape to exit keyboard loop" || call dk_error "call dk_echo failed!"
goto:eof