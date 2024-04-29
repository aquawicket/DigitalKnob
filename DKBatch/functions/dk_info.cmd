@echo off
call dk_includeGuard
call DK

if "%ENABLE_dk_info%"=="" set ENABLE_dk_info=1
if "%TRACE_ON_INFO%"==""  set TRACE_ON_INFO=0
if "%PAUSE_ON_INFO%"==""  set PAUSE_ON_INFO=0
if "%HALT_ON_INFO%"==""   set HALT_ON_INFO=0
::INFO_TAG="  INFO: "
::################################################################################
::# dk_info(<message>)
::#
::#	    Print a info message to the console
::#
::#     @msg	- The message to print
::#
:dk_info () {
	call dk_debugFunc
	
	if "%ENABLE_dk_info%" NEQ "1" goto:eof
	setlocal enableDelayedExpansion	
		set "msg=%1"
		
		:: if msg starts and ends with quotes, remove the first and last
		if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
		
		::call dk_toVariableInfo msg
		
		call dk_echo %white%%INFO_TAG%%msg%%clr%
		if "%TRACE_ON_INFO%"=="1" call dk_echo %white%*** TRACE_ON_ERROR ***%clr% & call dk_stacktrace
		if "%HALT_ON_INFO%"=="1"  call dk_echo %white%*** HALT_ON_INFO ***%clr%   & call dk_exit
		if "%PAUSE_ON_INFO%"=="1" call dk_echo %white%*** PAUSE_ON_INFO ***%clr%  & call dk_pause
	endlocal
goto:eof