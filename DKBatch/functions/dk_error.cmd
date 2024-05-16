@echo off
call DK

if not defined ENABLE_dk_error  set "ENABLE_dk_error=1"
if not defined TRACE_ON_ERROR   set "TRACE_ON_ERROR=1"
if not defined LINE_ON_ERROR    set "LINE_ON_ERROR=1"
if not defined PAUSE_ON_ERROR   set "PAUSE_ON_ERROR=1"
if not defined HALT_ON_ERROR    set "HALT_ON_ERROR=1"
:: ERROR_TAG="ERROR: "
::################################################################################
::# dk_error(<message>)
::#
::#    Print a error message to the console
::#
::#    @message - The message to print
::#
:dk_error () {
	::call dk_debugFunc
	
	if "%ENABLE_dk_error%" neq "1"  goto:eof
	
	
	setlocal enableDelayedExpansion	
		set "_message_=%*"
		if "" == %_message_:~0,1%%_message_:~-1% set "_message_=!_message_:~1,-1!"           &:: if _message_ starts and ends with quotes, remove them
		
		::echo %red%%ERROR_TAG%%_message_%%clr%
		call dk_echo %red%%ERROR_TAG%%_message_%%clr%
		set "ENABLE_dk_debugFunc=0"
		if "%TRACE_ON_ERROR%"=="1" call dk_echo %red%*** TRACE_ON_ERROR ***%clr% & call dk_stacktrace
		if "%LINE_ON_ERROR%"=="1"  call dk_echo %red%*** LINE_ON_ERROR ***%clr%  & call dk_showFileLine %_callerpath% %_message_%
		if "%PAUSE_ON_ERROR%"=="1" call dk_echo %red%*** PAUSE_ON_ERROR ***%clr% & call dk_pause
		if "%HALT_ON_ERROR%"=="1"  call dk_echo %red%*** HALT_ON_ERROR ***%clr%  & cmd /k
	endlocal 
goto:eof




:DKTEST ########################################################################

	call dk_error "test dk_error message"
	echo "...next line..."