@echo off
if not defined DKINIT (call DK & call :TEST_dk_debug)
call dk_includeGuard

if "%ENABLE_dk_debug%"=="" set ENABLE_dk_debug=1
if "%TRACE_ON_DEBUG%"==""  set TRACE_ON_DEBUG=0
if "%PAUSE_ON_DEBUG%"==""  set PAUSE_ON_DEBUG=0
if "%HALT_ON_DEBUG%"==""   set HALT_ON_DEBUG=0
::DEBUG_TAG="  DEBUG: "
::##################################################################################
::# dk_debug(<msg>)
::#
::#   Print a debug message to the console
::#
::#   @msg	- The message to print
::#
:dk_debug () {
	call dk_debugFunc
	
	if "%ENABLE_dk_debug%" NEQ "1"  goto:eof
	if ""=="%*"  echo. & goto:eof				              &:: if argument is empty, print a new line
	
	setlocal enableDelayedExpansion       
		set "msg=%*"
		if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"    &:: if msg starts and ends with quotes, remove them
		
		call dk_toVariableInfo msg
		
		call dk_echo %blue%%DEBUG_TAG%%msg%%clr%
		if "%TRACE_ON_DEBUG%"=="1" call dk_echo %blue%*** TRACE_ON_DEBUG ***%clr%  & call dk_stacktrace
		if "%HALT_ON_DEBUG%"=="1"  call dk_echo %blue%*** HALT_ON_DEBUG ***%clr%   & call dk_exit
		if "%PAUSE_ON_DEBUG%"=="1" call dk_echo %blue%*** PAUSE_ON_DEBUG ***%clr%  & call dk_pause
	endlocal
goto:eof




::################################ DKTEST #########################################
:TEST_dk_debug
	call :dk_debug "called from TEST portion of the script"
	call dk_exit
goto:eof