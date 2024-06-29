@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd
if "%~1" equ "BeginReceiving" goto %1


::################################################################################
::# dk_keyboard()
::#
::#
:dk_keyboard (){
	setlocal EnableDelayedExpansion
	:loop
	   call :Keyboard_Loop
	if %select% neq 0 goto Loop
goto:EOF


:Keyboard_Loop
	setlocal EnableDelayedExpansion
	set "Enter=13" 
	set "Esc=27" 
	set "End=35" 
	set "Home=36" 
	set "LeftArrow=37" 
	set "RightArrow=39"
	for /F %%a in ('copy /Z "%~F0" NUL') do set "CR=%%a"
	for /F %%a in ('echo prompt $H ^| cmd') do set "BS=%%a"

	rem Read keys via PowerShell  ->  Process keys in Batch
	PowerShell  ^
	   Write-Host 0;  ^
	   while (1) {  ^
		  $key = $Host.UI.RawUI.ReadKey('NoEcho,IncludeKeyDown').VirtualKeyCode;  ^
		  Write-Host $key  ^
	   }  ^
	%End PowerShell%  |  "%~F0" BeginReceiving %2
	endlocal & set "%~1=%errorlevel%"
goto:eof

:BeginReceiving
	setlocal EnableDelayedExpansion
	rem Wait for PS code start signal
	set /P "keyCode="
	set /P "="
:PollKeys
    rem Get a keycode from PowerShell
    set /P "keyCode="
    set /P "="
    echo keyCode = %keyCode%
    if %keyCode% equ 13 echo "Enter"
    if %keyCode% equ 27 echo "Esc" 
    if %keyCode% equ 35 echo "End" 
    if %keyCode% equ 36 echo "Home" 
    if %keyCode% equ 37 echo "LeftArrow" 
    if %keyCode% equ 39 echo "RightArrow"
goto PollKeys

:endSelection
exit %sel%






:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_keyboard
goto:eof