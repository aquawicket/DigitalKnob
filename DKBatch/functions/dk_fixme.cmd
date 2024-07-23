@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::if not defined ENABLE_dk_fixme  set "ENABLE_dk_fixme=1"
::if not defined TRACE_ON_FIXME   set "TRACE_ON_FIXME=0"
::if not defined LINE_ON_FIXME    set "LINE_ON_FIXME=0"
::if not defined PAUSE_ON_FIXME   set "PAUSE_ON_FIXME=0"
::if not defined HALT_ON_FIXME    set "HALT_ON_FIXME=0"
::set "FIXME_TAG=FIXME: "
::################################################################################
::# dk_fixme(message)
::#
::#    Print a fixme message to the console
::#
::#    @message - The message to print
::#
:dk_fixme
	call dk_debugFunc
	if %__ARGC__% neq 1 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	
	if not defined ENABLE_dk_fixme  set "ENABLE_dk_fixme=1"
	if "%ENABLE_dk_fixme%" neq "1"  goto:eof
	setlocal
		set "_message_=%~1"
		::if "" == %_message_:~0,1%%_message_:~-1% call dk_set _message_ !_message_:~1,-1!          &:: if _message_ starts and ends with quotes, remove them
		
		call dk_echo "%red%%FIXME_TAG%%_message_%%clr%"
		if "%TRACE_ON_FIXME%"=="1" call dk_echo "%red%*** TRACE_ON_FIXME ***%clr%" & call dk_stacktrace
		if "%LINE_ON_FIXME%"=="1"  call dk_echo "%red%*** LINE_ON_FIXME ***%clr%"  & call dk_showFileLine "%_callerpath%" "%_message_%"
		if "%PAUSE_ON_FIXME%"=="1" call dk_echo "%red%*** PAUSE_ON_FIXME ***%clr%" & call dk_pause
		if "%HALT_ON_FIXME%"=="1"  call dk_echo "%red%*** HALT_ON_FIXME ***%clr%"  & call dk_exit
	endlocal 
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_fixme "test dk_fixme message"
goto:eof
