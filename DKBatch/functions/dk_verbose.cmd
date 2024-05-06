@echo off
call DK

setlocal enableDelayedExpansion
if "%ENABLE_dk_verbose%"=="" set ENABLE_dk_verbose=1
if "%TRACE_ON_VERBOSE%"==""  set TRACE_ON_VERBOSE=0
if "%PAUSE_ON_VERBOSE%"==""  set PAUSE_ON_VERBOSE=0
if "%HALT_ON_VERBOSE%"==""   set HALT_ON_VERBOSE=0
::TAG="  VERBOSE: "
::################################################################################
::# dk_verbose(<message>)
::#
::#	    Print a verbose message to the console
::#
::#     @msg	- The message to print
::#
:dk_verbose () {
	::call dk_debugFunc
	
	if "%ENABLE_dk_verbose%" NEQ "1" goto:eof
	set "msg=%1"
	
	:: if msg starts and ends with quotes, remove the first and last
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	call dk_echo %cyan%%TAG%%msg%%clr%
	if "%TRACE_ON_VERBOSE%"=="1" call dk_stacktrace 		
	if "%HALT_ON_VERBOSE%"=="1"  call dk_exit
	if "%PAUSE_ON_VERBOSE%"=="1" call dk_pause
	
endlocal
goto:eof