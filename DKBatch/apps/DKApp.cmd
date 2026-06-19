@echo off

set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" equ "%func:~0,1%" (goto %func%)

if /i "%~1" equ "DKApp.onKeyDown" (goto:%~1)


::### get _argc and _argv ###
set _argv=%*
set /a "_argc=0"
for %%x in (%*) do (
	set /a _argc+=1
)

set "ESC="
set "SPACE= "

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



::########################################
::# DKApp(_argc, _argv)
::#
::#
:DKApp
	::echo %ESC%[19;200H                    
	::echo %ESC%[19;20HF:%~nx0 %*
	
	::dk_debugFuncv _argc _argv
	set "DKApp.argc=%_argc%"
	set "DKApp.argv=%_argv%"
	
	::echo DKApp.argc = %DKApp.argc%
	::echo DKApp.argv = %DKApp.argv%
	call :DKApp.init
	call :DKApp.Loop
%endfunction%

:DKApp.init
	::echo %ESC%[19;200H                    
	::echo %ESC%[19;20HF:%~nx0 %*
	set "DKApp.active=1"
	
	%dk_call% dk_keyboard callback "%~d0\:DKApp.onKeyDown\..%~pnx0"
	::echo %ESC%[?25l    &rem Hide Cursor
%endfunction%

:DKApp.Loop
	for /L %%G in (0) do (
		title %time%
		rem echo %ESC%[0;0HT:
		rem echo %ESC%[0;0HT:%time%
		rem if NOT defined DKApp.active %return%
	)	
%endfunction%

:DKApp.exit
	::echo %ESC%[19;200H                 
	::echo %ESC%[19;20HF:%~nx0 %*
	
	echo dk_exit
	%dk_call% dk_exit 0
%endfunction%


:DKApp.onKeyDown
	::echo DKApp.onKeyDown %*
	
	echo keyCode: %~1
	if %~1 equ 27 (set "callback=")
	if "%~1" equ "" (
		(call)
		%return%
	)
	
	::echo %ESC%[21;0HDKApp_onKeyDown %*
	::echo %ESC%[19;70H            &::
	::echo %ESC%[19;70HKeyCode:%~1
	
	::if "%~1" equ "13" (echo "Enter")
	::if %~1 equ 35 (echo "End")
	::if %~1 equ 36 (echo "Home")
	::if %~1 equ 37 (echo "LeftArrow")
	::if %~1 equ 39 (echo "RightArrow")
	
%endfunction%