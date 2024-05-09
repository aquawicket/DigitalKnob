@echo off
call DK

if not defined ENABLE_dk_verbose  set "ENABLE_dk_verbose=1"
if not defined TRACE_ON_VERBOSE   set "TRACE_ON_VERBOSE=0"
if not defined LINE_ON_VERBOSE    set "LINE_ON_VERBOSE=0"
if not defined PAUSE_ON_VERBOSE   set "PAUSE_ON_VERBOSE=0"
if not defined HALT_ON_VERBOSE    set "HALT_ON_VERBOSE=0"
::TAG="  VERBOSE: "
::################################################################################
::# dk_verbose(<message>)
::#
::#	    Print a verbose message to the console
::#
::#     @message	- The message to print
::#
:dk_verbose () {
	::call dk_debugFunc
	
	if "%ENABLE_dk_verbose%" neq "1" goto:eof
	
	
	setlocal enableDelayedExpansion
		set "_message_=%*"
		if "" == %_message_:~0,1%%_message_:~-1% set "_message_=!_message_:~1,-1!"           &:: if _message_ starts and ends with quotes, remove them
	
		call dk_echo %cyan%%TAG%%_message_%%clr%
		set "ENABLE_dk_debugFunc=0"
		if "%TRACE_ON_VERBOSE%"=="1" call dk_echo %blue%*** TRACE_ON_VERBOSE ***%clr%  & call dk_stacktrace
		if "%LINE_ON_VERBOSE%"=="1"  call dk_echo %blue%*** LINE_ON_VERBOSE ***%crl%   & call dk_showFileLine %_callerpath% %_message_%
		if "%PAUSE_ON_VERBOSE%"=="1" call dk_echo %blue%*** PAUSE_ON_VERBOSE ***%clr%  & call dk_pause
		if "%HALT_ON_VERBOSE%"=="1"  call dk_echo %blue%*** HALT_ON_VERBOSE ***%clr%   & cmd /k
	endlocal
goto:eof