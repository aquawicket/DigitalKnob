@echo off
call DK

if not defined ENABLE_dk_fixme  set "ENABLE_dk_fixme=1"
if not defined TRACE_ON_FIXME   set "TRACE_ON_FIXME=1"
if not defined LINE_ON_FIXME    set "LINE_ON_FIXME=1"
if not defined PAUSE_ON_FIXME   set "PAUSE_ON_FIXME=1"
if not defined HALT_ON_FIXME    set "HALT_ON_FIXME=1"
:: FIXME_TAG="FIXME: "
::################################################################################
::# dk_fixme(<message>)
::#
::#    Print a fixme message to the console
::#
::#    @message - The message to print
::#
:dk_fixme () {
	::call dk_debugFunc
	
	if "%ENABLE_dk_fixme%" neq "1"  goto:eof
	
	
	setlocal enableDelayedExpansion	
		set "_message_=%*"
		if "" == %_message_:~0,1%%_message_:~-1% set "_message_=!_message_:~1,-1!"           &:: if _message_ starts and ends with quotes, remove them
		
		::echo %red%%FIXME_TAG%%_message_%%clr%
		call dk_echo %red%%FIXME_TAG%%_message_%%clr%
		::set "ENABLE_dk_debugFunc=0"
		if "%TRACE_ON_FIXME%"=="1" call dk_echo %red%*** TRACE_ON_FIXME ***%clr% & call dk_stacktrace
		if "%LINE_ON_FIXME%"=="1"  call dk_echo %red%*** LINE_ON_FIXME ***%clr%  & call dk_showFileLine "%_callerpath%" "%_message_%"
		if "%PAUSE_ON_FIXME%"=="1" call dk_echo %red%*** PAUSE_ON_FIXME ***%clr% & call dk_pause
		if "%HALT_ON_FIXME%"=="1"  call dk_echo %red%*** HALT_ON_FIXME ***%clr%  & call dk_exit
	endlocal 
goto:eof




:DKTEST ########################################################################

	call dk_fixme "test dk_fixme message"
	echo "...next line..."
