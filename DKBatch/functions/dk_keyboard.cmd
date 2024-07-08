@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd
if "%~1" equ "BeginReceiving" goto %1


::################################################################################
::# dk_keyboard()
::#
::#
:dk_keyboard
	call dk_debugFunc
	
	call :Keyboard_Loop

	:Keyboard_Loop
		rem Read keys via PowerShell  ->  Process keys in Batch
		PowerShell  ^
		   Write-Host 0;  ^
		   while ($key -ne 27) {  ^
			  $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode;  ^
			  Write-Host $key  ^
		   }  ^
		%End PowerShell%  |  "%~F0" BeginReceiving %2
		::endlocal & set "%~1=%errorlevel%"
	goto:eof

	:BeginReceiving
		setlocal EnableDelayedExpansion
		rem Wait for PS code start signal
		set /P "keyCode="
		set /P "="
		:pollKeys
		rem Get a keycode from PowerShell
		set /P "keyCode="
		set /P "="
		echo keyCode = %keyCode%
		if %keyCode% equ 13 echo "Enter"
		if %keyCode% equ 27 echo "Esc" & goto endSelection
		if %keyCode% equ 35 echo "End" 
		if %keyCode% equ 36 echo "Home" 
		if %keyCode% equ 37 echo "LeftArrow" 
		if %keyCode% equ 39 echo "RightArrow"
		rem for /F %%a in ('copy /Z "%~F0" NUL') do set "CR=%%a"
		rem for /F %%a in ('echo prompt $H ^| cmd') do set "BS=%%a"
	goto pollKeys

	:endSelection
	exit 0
goto:eof





::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_keyboard
goto:eof