@echo off
call DK

if not defined ENABLE_dk_warning  set "ENABLE_dk_warning=1"
if not defined TRACE_ON_WARNING   set "TRACE_ON_WARNING=0"
if not defined LINE_ON_WARNING    set "LINE_ON_WARNING=0"
if not defined PAUSE_ON_WARNING   set "PAUSE_ON_WARNING=0"
if not defined HALT_ON_WARNING    set "HALT_ON_WARNING=0"
::WARNING_TAG="  WARNING: "
::################################################################################
::# dk_warning(message)
::#
::#	   Print a warning message to the console
::#
::#	   @message	- The message to print
::#
:dk_warning () {
	call dk_debugFunc
	
	if "%ENABLE_dk_warning%" neq "1" goto:eof
	
	
	setlocal enableDelayedExpansion	
		set "_message_=%*"
		if "" == %_message_:~0,1%%_message_:~-1% set "_message_=!_message_:~1,-1!"           &:: if _message_ starts and ends with quotes, remove them
		
		::echo %yellow%%WARNING_TAG%%_message_%%clr%
		call dk_echo %yellow%%WARNING_TAG%%_message_%%clr%
		set "ENABLE_dk_debugFunc=0"
		if "%TRACE_ON_WARNING%"=="1" call dk_echo %blue%*** TRACE_ON_WARNING ***%clr%  & call dk_stacktrace
		if "%LINE_ON_WARNING%"=="1"  call dk_echo %blue%*** LINE_ON_WARNING ***%crl%   & call dk_showFileLine "%_callerpath%" "%_message_%"
		if "%PAUSE_ON_WARNING%"=="1" call dk_echo %blue%*** PAUSE_ON_WARNING ***%clr%  & call dk_pause
		if "%HALT_ON_WARNING%"=="1"  call dk_echo %blue%*** HALT_ON_WARNING ***%clr%   & call dk_exit
	endlocal
goto:eof




:DKTEST ########################################################################
	
	call dk_warning "test dk_warning message"
	call dk_info "...next line..."