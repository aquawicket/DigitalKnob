@echo off

set "func=%~0"
for /F "delims=\" %%X in ("%func:*\=%") do set "func=%%X"
if ":" == "%func:~0,1%" (goto %func%)

if "%~1" equ "DKApp.onKeyDown" (goto:%~1)


::### get _argc and _argv ###
set _argv=%*
set /a "_argc=0"
for %%x in (%*) do (
	set /a _argc+=1
)

set "ESC="
set "SPACE= "

if not exist "%DKBATCH_FUNCTIONS_DIR_%"  (set "DKBATCH_FUNCTIONS_DIR_=%CD%\..\functions\")
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)



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
	::echo %ESC%[?25l    &:: Hide Cursor
%endfunction%

:DKApp.Loop
	for /L %%G in (0) do (
		title %time%
		rem echo %ESC%[0;0HT:
		rem echo %ESC%[0;0HT:%time%
		rem if not defined DKApp.active %return%
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
	if "%~1" == "" (
		(call)
		%return%
	)
	
	::echo %ESC%[21;0HDKApp_onKeyDown %*
	::echo %ESC%[19;70H            &::
	::echo %ESC%[19;70HKeyCode:%~1
	
	::if "%~1"=="13" (echo "Enter")
	::if %~1 equ 35 (echo "End")
	::if %~1 equ 36 (echo "Home")
	::if %~1 equ 37 (echo "LeftArrow")
	::if %~1 equ 39 (echo "RightArrow")
	
%endfunction%