@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::if not defined ENABLE_dk_info  set "ENABLE_dk_info=1"
::if not defined TRACE_ON_INFO   set "TRACE_ON_INFO=0"
::if not defined LINE_ON_INFO    set "LINE_ON_INFO=0"
::if not defined PAUSE_ON_INFO   set "PAUSE_ON_INFO=0"
::if not defined HALT_ON_INFO    set "HALT_ON_INFO=0"
::INFO_TAG="  INFO: "
::################################################################################
::# dk_info(message)
::#
::#    Print a info message to the console
::#
::#    @message	- The message to print
::#
:dk_info
	call dk_debugFunc
	if %__ARGC__% NEQ 1 call dk_error "%__FUNCTION__%(): incorrect number of arguments"
	
	
	if not defined ENABLE_dk_info  set "ENABLE_dk_info=1"
	if "%ENABLE_dk_info%" neq "1" goto:eof
	setlocal
		set "_message_=%~1"
		::if "" == %_message_:~0,1%%_message_:~-1% set "_message_=!_message_:~1,-1!"    &:: if _message_ starts and ends with quotes, remove them
		
		call dk_echo "%white%%INFO_TAG%%_message_%%clr%"
		if "%TRACE_ON_INFO%"=="1" call dk_echo "%white%*** TRACE_ON_INFO ***%clr%" & call dk_stacktrace
		if "%LINE_ON_INFO%"=="1"  call dk_echo "%white%*** LINE_ON_INFO ***%crl%"  & call dk_showFileLine "%_callerpath%" "%_message_%"
		if "%PAUSE_ON_INFO%"=="1" call dk_echo "%white%*** PAUSE_ON_INFO ***%clr%" & call dk_pause
		if "%HALT_ON_INFO%"=="1"  call dk_echo "%white%*** HALT_ON_INFO ***%clr%"  & call dk_exit
	endlocal
goto:eof




::####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST ####### DKTEST #######
:DKTEST
	call dk_debugFunc
	
	call dk_info "test string from dk_info"
goto:eof
