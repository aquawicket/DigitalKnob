@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::call dk_set ENABLE_dk_warning 0
::call dk_set TRACE_ON_WARNING 1
::call dk_set LINE_ON_WARNING 1
::call dk_set PAUSE_ON_WARNING 1
::call dk_set HALT_ON_WARNING 1
::call dk_set WARNING_TAG=" WARNING: "
::################################################################################
::# dk_warning(message)
::#
::#	   Print a warning message to the console
::#
::#	   @message	- The message to print
::#
:dk_warning
	call dk_debugFunc 1
	
	
	if not defined ENABLE_dk_warning  set "ENABLE_dk_warning=1"
	if "%ENABLE_dk_warning%" neq "1" goto:eof                                                               &:: if arguments are empty, print a new line
	setlocal
		set "_message_=%~1"
		::if "" == %_message_:~0,1%%_message_:~-1% call dk_set _message_ !_message_:~1,-1!           &:: if _message_ starts and ends with quotes, remove them

		call dk_echo "%yellow%%WARNING_TAG%%_message_%%clr%"
		if "%TRACE_ON_WARNING%"=="1" call dk_echo "%yellow%*** TRACE_ON_WARNING ***%clr%"  & call dk_stacktrace
		if "%LINE_ON_WARNING%"=="1"  call dk_echo "%yellow%*** LINE_ON_WARNING ***%crl%"   & call dk_showFileLine "%_callerpath%" "%_message_%"
		if "%PAUSE_ON_WARNING%"=="1" call dk_echo "%yellow%*** PAUSE_ON_WARNING ***%clr%"  & call dk_pause
		if "%HALT_ON_WARNING%"=="1"  call dk_echo "%yellow%*** HALT_ON_WARNING ***%clr%"   & call dk_exit
	endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_warning "test dk_warning message"
goto:eof
