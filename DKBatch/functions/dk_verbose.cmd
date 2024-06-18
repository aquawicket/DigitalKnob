@echo off
call DK

if not defined ENABLE_dk_verbose  call dk_set ENABLE_dk_verbose 1
if not defined TRACE_ON_VERBOSE   call dk_set TRACE_ON_VERBOSE 0
if not defined LINE_ON_VERBOSE    call dk_set LINE_ON_VERBOSE 0
if not defined PAUSE_ON_VERBOSE   call dk_set PAUSE_ON_VERBOSE 0
if not defined HALT_ON_VERBOSE    call dk_set HALT_ON_VERBOSE 0
::VERBOSE)TAG="  VERBOSE: "
::################################################################################
::# dk_verbose(message)
::#
::#	   Print a verbose message to the console
::#
::#    @message	- The message to print
::#
:dk_verbose () {
	call dk_debugFunc
	
	if "%ENABLE_dk_verbose%" neq "1" goto:eof
	::if "%*"==""  echo. & goto:eof				                                      &:: if arguments are empty, print a new line
	
	setlocal enableDelayedExpansion
		call dk_set _message_ %*
		if "" == %_message_:~0,1%%_message_:~-1% call dk_set _message_ !_message_:~1,-1!    &:: if _message_ starts and ends with quotes, remove them
	
		if not defined magenta (call dk_set magenta [35m)
		if not defined clr (call dk_set clr [0m)
		call dk_echo "%magenta%%VERBOSE_TAG%%_message_%%clr%"
		if "%TRACE_ON_VERBOSE%"=="1" call dk_echo "%magenta%*** TRACE_ON_VERBOSE ***%clr%"  & call dk_stacktrace
		if "%LINE_ON_VERBOSE%"=="1"  call dk_echo "%magenta%*** LINE_ON_VERBOSE ***%crl%"   & call dk_showFileLine "%_callerpath%" "%_message_%"
		if "%PAUSE_ON_VERBOSE%"=="1" call dk_echo "%magenta%*** PAUSE_ON_VERBOSE ***%clr%"  & call dk_pause
		if "%HALT_ON_VERBOSE%"=="1"  call dk_echo "%magenta%*** HALT_ON_VERBOSE ***%clr%"   & call dk_exit
	endlocal
goto:eof




:DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ###
	call dk_debugFunc
	
	call dk_verbose "test dk_verbose message"
goto:eof