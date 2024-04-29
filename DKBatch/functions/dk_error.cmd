@echo off
call dk_includeGuard
call DK

if "%ENABLE_dk_error%"==""  set ENABLE_dk_error=1
if "%TRACE_ON_ERROR%"==""   set TRACE_ON_ERROR=1
if "%LINE_ON_ERROR%"==""    set LINE_ON_ERROR=1
if "%PAUSE_ON_ERROR%"==""   set PAUSE_ON_ERROR=1
if "%HALT_ON_ERROR%"==""    set HALT_ON_ERROR=1
:: ERROR_TAG="ERROR: "
::################################################################################
::# dk_error(<msg>)
::#
::#	Print a error message to the console
::#
::#	@msg - The message to print
::#
:dk_error () {
	call dk_debugFunc
	
	if "%ENABLE_dk_error%" NEQ "1"  goto:eof
	setlocal enableDelayedExpansion	
		set "msg=%1"
				
		:: if msg starts and ends with quotes, remove the first and last characters
		if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
		
		::call dk_toVariableInfo msg
		
		call dk_echo %red%%ERROR_TAG%%msg%%clr%
		if "%TRACE_ON_ERROR%"=="1" call dk_echo %red%*** TRACE_ON_ERROR ***%clr% & call dk_stacktrace
		if "%LINE_ON_ERROR%"=="1"  call dk_echo %red%*** LINE_ON_ERROR ***%clr%  & call dk_showFileLine %_callerpath% %msg%
		if "%HALT_ON_ERROR%"=="1"  call dk_echo %red%*** HALT_ON_ERROR ***%clr%  & call dk_exit
		if "%PAUSE_ON_ERROR%"=="1" call dk_echo %red%*** PAUSE_ON_ERROR ***%clr% & call dk_pause
	endlocal 
goto:eof