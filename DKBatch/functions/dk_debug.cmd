@echo off
call DK.cmd

::call dk_set ENABLE_dk_debug 0
::call dk_set TRACE_ON_DEBUG 1
::call dk_set LINE_ON_DEBUG 1
::call dk_set PAUSE_ON_DEBUG 1
::call dk_set HALT_ON_DEBUG 1
::call dk_set DEBUG_TAG " DEBUG: "
::##################################################################################
::# dk_debug(<message>)
::#
::#    Print a debug message to the console
::#
::#    @message	- The message to print
::#
:dk_debug () {
	call dk_debugFunc
	if %__ARGC__% NEQ 1 (call dk_error "%__FUNCTION__%(): not enough arguments")
	
	
	if not defined ENABLE_dk_debug  call set "ENABLE_dk_debug=1"
	if "%ENABLE_dk_debug%" neq "1"  goto:eof
	setlocal enableDelayedExpansion       
		call dk_set _message_ %*
		if "" == %_message_:~0,1%%_message_:~-1% call dk_set _message_ !_message_:~1,-1!    &:: if _message_ starts and ends with quotes, remove them

		call dk_echo "%blue%%DEBUG_TAG%%_message_%%clr%"
		if "%TRACE_ON_DEBUG%"=="1" call dk_echo "%blue%*** TRACE_ON_DEBUG ***%clr%"  & call dk_stacktrace
		if "%LINE_ON_DEBUG%"=="1"  call dk_echo "%blue%*** LINE_ON_DEBUG ***%crl%"   & call dk_showFileLine "%_callerpath%" "%_message_%"
		if "%PAUSE_ON_DEBUG%"=="1" call dk_echo "%blue%*** PAUSE_ON_DEBUG ***%clr%"  & call dk_pause
		if "%HALT_ON_DEBUG%"=="1"  call dk_echo "%blue%*** HALT_ON_DEBUG ***%clr%"   & call dk_exit
	endlocal
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_debug "test dk_debug message"
goto:eof