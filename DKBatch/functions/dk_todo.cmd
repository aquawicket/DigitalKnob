@echo off
call DK

if not defined ENABLE_dk_todo  set "ENABLE_dk_todo=1"
if not defined TRACE_ON_TODO   set "TRACE_ON_TODO=0"
if not defined LINE_ON_TODO    set "LINE_ON_TODO=0"
if not defined PAUSE_ON_TODO   set "PAUSE_ON_TODO=0"
if not defined HALT_ON_TODO    set "HALT_ON_TODO=0"
set "TODO_TAG=  TODO: "
::##################################################################################
::# dk_todo(<message>)
::#
::#    Print a todo message to the console
::#
::#    @message	- The message to print
::#
:dk_todo () {
	::call dk_debugFunc
	
	if "%ENABLE_dk_todo%" neq "1"  goto:eof
	::if "%*"==""  echo. & goto:eof				                                      &:: if arguments are empty, print a new line
	
	setlocal enableDelayedExpansion       
		set "_message_=%*"
		if "" == %_message_:~0,1%%_message_:~-1% set "_message_=!_message_:~1,-1!"    &:: if _message_ starts and ends with quotes, remove them
		
		::echo %yellow%%TODO_TAG%%_message_%%clr%
		call dk_echo %yellow%%TODO_TAG%%_message_%%clr%
		::set "ENABLE_dk_debugFunc=0"
		if "%TRACE_ON_TODO%"=="1" call dk_echo %yellow%*** TRACE_ON_TODO ***%clr%  & call dk_stacktrace
		if "%LINE_ON_TODO%"=="1"  call dk_echo %yellow%*** LINE_ON_TODO ***%crl%   & call dk_showFileLine %_callerpath% %_message_%
		if "%PAUSE_ON_TODO%"=="1" call dk_echo %yellow%*** PAUSE_ON_TODO ***%clr%  & call dk_pause
		if "%HALT_ON_TODO%"=="1"  call dk_echo %yellow%*** HALT_ON_TODO ***%clr%   & cmd /k
	endlocal
goto:eof




:DKTEST ########################################################################
	
	call dk_todo "test dk_todo message"
	call dk_info "...next line..."
