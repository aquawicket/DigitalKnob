@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::if not defined ENABLE_dk_todo  call dk_set ENABLE_dk_todo 1
::if not defined TRACE_ON_TODO   call dk_set TRACE_ON_TODO 0
::if not defined LINE_ON_TODO    call dk_set LINE_ON_TODO 0
::if not defined PAUSE_ON_TODO   call dk_set PAUSE_ON_TODO 0
::if not defined HALT_ON_TODO    call dk_set HALT_ON_TODO 0
::call dk_set TODO_TAG "  TODO: "
::##################################################################################
::# dk_todo(message)
::#
::#    Print a todo message to the console
::#
::#    @message	- The message to print
::#
:dk_todo
	call dk_debugFunc
	if %__ARGC__% NEQ 1 call dk_error "%__FUNCTION__%(): incorrect number of arguments"
	
	
	if not defined ENABLE_dk_todo  set "ENABLE_dk_todo=1"
	if "%ENABLE_dk_todo%" neq "1"  goto:eof
	setlocal     
		set "_message_=%~1"
		::if "" == %_message_:~0,1%%_message_:~-1% call dk_set _message_ !_message_:~1,-1!    &:: if _message_ starts and ends with quotes, remove them
		
		call dk_echo "%yellow%%TODO_TAG%%_message_%%clr%"
		if "%TRACE_ON_TODO%"=="1" call dk_echo "%yellow%*** TRACE_ON_TODO ***%clr%"  & call dk_stacktrace
		if "%LINE_ON_TODO%"=="1"  call dk_echo "%yellow%*** LINE_ON_TODO ***%crl%"   & call dk_showFileLine "%_callerpath%" "%_message_%"
		if "%PAUSE_ON_TODO%"=="1" call dk_echo "%yellow%*** PAUSE_ON_TODO ***%clr%"  & call dk_pause
		if "%HALT_ON_TODO%"=="1"  call dk_echo "%yellow%*** HALT_ON_TODO ***%clr%"   & call dk_exit
	endlocal
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_todo "test dk_todo message"
goto:eof
