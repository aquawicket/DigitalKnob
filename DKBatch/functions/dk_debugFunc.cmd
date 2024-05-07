@echo off
call DK

if "%ENABLE_dk_debugFunc%"=="" set ENABLE_dk_debugFunc=1
if "%MAX_STACK_LINES%"==""     set "MAX_STACK_LINES=200"
if "%DKSTACK[0].FILE%"==""     set "DKSTACK[0].FILE=%0"
if "%DKSTACK[0].FUNCTION%"=="" set "DKSTACK[0].FUNCTION=main"
if "%DKSTACK[0].ARGS%"==""     set "DKSTACK[0].ARGS=0"
if "%DKSTACK_length%"==""      set /a "DKSTACK_length=1"
if "%DKSTACK_marker%"==""      set /a "DKSTACK_marker=1"
::################################################################################
::# dk_debugFunc()
::#
::#
:dk_debugFunc () {

	if not exist "%DKBATCH_DIR%\functions\dk_caller.cmd" powershell -Command "(New-Object Net.WebClient).DownloadFile('%DKHTTP%/dk_caller.cmd', '%DKBATCH_DIR%\functions\dk_caller.cmd')"
	call dk_caller DKCALLER
	:dk_caller
	set DKSTACK[%DKSTACK_marker%].FILE=%_filename%
	set DKSTACK[%DKSTACK_marker%].FUNCTION=%_func%
	set DKSTACK[%DKSTACK_marker%].ARGS=%_args%
	
::	call dk_getCaller 2
::	:dk_getCaller_return2
::	set DKSTACK[%DKSTACK_marker%].FILE=%caller[0].fullpath%
::	set DKSTACK[%DKSTACK_marker%].FUNCTION=%caller[0].func%
::	set DKSTACK[%DKSTACK_marker%].ARGS=%caller[0].args%
	
	
	set /a DKSTACK_length+=1
	set /a DKSTACK_marker=%DKSTACK_length%	
::	if %DKSTACK_length% LSS %MAX_STACK_LINES% (
::		set /a DKSTACK_length+=1
::		echo "growing DKSTACK_length to %DKSTACK_length%"
::	) else (
::		echo "DKSTACK_length is capped at %DKSTACK_length%"
::	)
::	if %DKSTACK_marker% LSS %DKSTACK_length% (
::		set /a DKSTACK_marker+=1
::		echo "advancing DKSTACK_marker to %DKSTACK_marker%"
::	) else (
::		set /a DKSTACK_marker=0
::		echo "resetting DKSTACK_marker to %DKSTACK_marker%"

	
	if "%ENABLE_dk_debugFunc%" neq "1" goto:eof
	set "cyan=[36m"
	set "clr=[0m"
	echo %_filename%: %cyan%%_func%(%_args%)%clr%
	
goto:eof