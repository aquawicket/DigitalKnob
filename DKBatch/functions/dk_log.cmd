@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################

rem ##################################################################################
rem # dk_log(<level> <message>)
rem #
rem #		Print a log message to the console
rem #
rem #		@level   - The message level: VERBOSE, DEBUG, DEFAULT, INFO, SUCCESS, TODO, NOTICE, FIXME, WARNING, ERROR, FATAL
rem #		@message - The message to print
rem #
:dk_log
	if NOT defined dk_log_ENABLE	(set "dk_log_ENABLE=1")

	rem ###### level order ######
	rem #		0 VERBOSE		dk_verbose
	rem #		1 DEBUG			dk_debug
	rem #		  DEFAULT		dk_default
	rem #		2 INFO			dk_info
	rem #		3 SUCCESS		dk_success
	rem #		4 TODO			dk_todo
	rem #		5 NOTICE		dk_notice
	rem #		6 FIXME			dk_fixme
	rem #		7 WARNING		dk_warning
	rem #		8 DEPRECATED	dk_deprecated
	rem #		9 ERROR			dk_error
	rem #      10 FATAL			dk_fatal

	rem ###### option order ######
	rem # 	ENABLE
	rem # 	COLOR
	rem # 	TAG
	rem # 	TRACE
	rem # 	LINE
	rem # 	SOUND
	rem # 	TIMEOUT
	rem # 	PAUSE
	rem # 	HALT
	
	if NOT defined dk_log_DEFAULT_ENABLE		(set "dk_log_DEFAULT_ENABLE=1")
	if NOT defined dk_log_DEFAULT_COLOR			(set "dk_log_DEFAULT_COLOR=%white%")
	rem if NOT defined dk_log_DEFAULT_TAG		(set "dk_log_DEFAULT_TAG=")
	rem if NOT defined dk_log_DEFAULT_TRACE		(set "dk_log_DEFAULT_TRACE=0")
	rem if NOT defined dk_log_DEFAULT_LINE		(set "dk_log_DEFAULT_LINE=0")
	rem if NOT defined dk_log_DEFAULT_SOUND		(set "dk_log_DEFAULT_SOUND=0")
	rem if NOT defined dk_log_DEFAULT_TIMEOUT	(set "dk_log_DEFAULT_TIMEOUT=0")
	rem if NOT defined dk_log_DEFAULT_PAUSE		(set "dk_log_DEFAULT_PAUSE=0")
	rem if NOT defined dk_log_DEFAULT_HALT		(set "dk_log_DEFAULT_HALT=0")
rem %setlocal%
setlocal enableDelayedExpansion

	if "%dk_log_ENABLE%" neq "1" (
		%return%
	)

	if "x!dk_log_LEVELS:%~1=!x" neq "x%dk_log_LEVELS%x" (
		set "_level_=%~1"
		 for /f "tokens=1*" %%a in ("%*") do (
      set _message_=%%~b
    )
		rem set "_message_=%~2"
rem		set dk_allButFirstArgs=%*	
rem		for /f "tokens=1*" %%a in ("!dk_allButFirstArgs!") do (set _message_=%%~b)
	) else if "%~2" equ "" (
		set "_level_=DEFAULT"
		set _message_=%*
	) else (
		echo. 
		%return%
	)
	
rem	if "%~2" equ "" (
rem		set "_level_=DEFAULT"
rem		set "_message_=%~1"
rem	)
	
rem	if "%~2" neq "" (
rem		set "_level_=%~1"
rem		set "_message_=%~2"
rem	)
	
	if "!dk_log_%_level_%_ENABLE!" neq "1" (
		%return%
	)

	rem ### remove surrounding quotes ###
	rem if "" == %_message_:~0,1%%_message_:~-1% (
	rem	%dk_call% dk_set _message_ %_message_:~1,-1%	&rem if _message_ starts and ends with quotes, remove them
	rem )

	rem ###### ECHO MESSAGE ######
	%dk_call% dk_echo "!dk_log_%_level_%_COLOR!!dk_log_%_level_%_TAG!%_message_%%clr%"

	rem ###### TRACE ######
	if "!dk_log_%_level_%_TRACE!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** TRACE_ON_%_level_% ***"
		%dk_call% dk_stacktrace
		%dk_call% dk_echo "%clr%"
	)

	rem ###### LINE ######
	if "!dk_log_%_level_%_LINE!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** LINE_ON_%_level_% ***"
		%dk_call% dk_showFileLine "%_callerpath%" "%_message_%"
		%dk_call% dk_echo "%clr%"
	)

	rem ###### SOUND ######
	if "!dk_log_%_level_%_SOUND!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** SOUND_ON_%_level_% ***"
		%dk_call% Array/dk_push errorBeeps "440,500"
		%dk_call% Array/dk_push errorBeeps "440,500"
		%dk_call% Array/dk_push errorBeeps "440,500"
		%dk_call% Array/dk_push errorBeeps "349,350"
		%dk_call% Array/dk_push errorBeeps "523,150"
		%dk_call% Array/dk_push errorBeeps "440,500"
		%dk_call% Array/dk_push errorBeeps "349,350"
		%dk_call% Array/dk_push errorBeeps "523,150"
		%dk_call% Array/dk_push errorBeeps "440,1000"
		%dk_call% Array/dk_push errorBeeps "659,500"
		%dk_call% Array/dk_push errorBeeps "659,500"
		%dk_call% Array/dk_push errorBeeps "659,500"
		%dk_call% Array/dk_push errorBeeps "698,350"
		%dk_call% Array/dk_push errorBeeps "523,150"
		%dk_call% Array/dk_push errorBeeps "415,500"
		%dk_call% Array/dk_push errorBeeps "349,350"
		%dk_call% Array/dk_push errorBeeps "523,150"
		%dk_call% Array/dk_push errorBeeps "440,1000"
		%dk_call% dk_beeps errorBeeps
		%dk_call% dk_echo "%clr%"
	)
	
	rem ###### CALLBACK ######
	if "!dk_log_%_level_%_CALLBACK!" neq "" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** CALLBACK_ON_%_level_% ***"
		%dk_call% dk_echo "%clr%"
		!dk_log_%_level_%_CALLBACK! "%_level_%" "%_message_%"
	)
	
	rem ###### TIMEOUT ######
	if "!dk_log_%_level_%_TIMEOUT!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** TIMEOUT_ON_%_level_% ***"
		%dk_call% dk_timeout !dk_log_%_level_%_TIMEOUT!
		%dk_call% dk_echo "%clr%"
	) 
	
	rem ###### PAUSE ######
	if "!dk_log_%_level_%_PAUSE!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** PAUSE_ON_%_level_% ***"
		%dk_call% dk_pause
		%dk_call% dk_echo "%clr%"
	)
	
	rem ###### HALT ######
	if "!dk_log_%_level_%_HALT!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** HALT_ON_%_level_% ***"
		%dk_call% dk_exit 13
		%dk_call% dk_echo "%clr%"
	)

%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

rem	%dk_call% dk_log DEFAULT	 test dk_log DEFAULT message without quotes
rem	%dk_call% dk_log VERBOSE	"test dk_log VERBOSE message"
rem	%dk_call% dk_log DEBUG		"test dk_log DEBUG message"
rem	%dk_call% dk_log			"test dk_log message"
rem	%dk_call% dk_log INFO		"test dk_log INFO message"
rem	%dk_call% dk_log SUCCESS	"test dk_log SUCCESS message"
rem	%dk_call% dk_log TODO		"test dk_log TODO message"
rem	%dk_call% dk_log NOTICE		"test dk_log NOTICE message"
rem	%dk_call% dk_log FIXME		"test dk_log FIXME message"
rem	%dk_call% dk_log WARNING	"test dk_log WARNING message"
rem	%dk_call% dk_log DEPRECATED	"test dk_log DEPRECATED message"
rem	%dk_call% dk_log ERROR		"test dk_log ERROR message"
rem	%dk_call% dk_log FATAL		"test dk_log FATAL message"

%dk_call% dk_log "test dk_log message"
%dk_call% dk_verbose "test dk_verbose message"
%dk_call% dk_debug "test dk_debug message"
%dk_call% dk_info "test dk_info message"
%dk_call% dk_success "test dk_success message"
%dk_call% dk_todo "test dk_todo message"
%dk_call% dk_notice "test dk_notice message"
%dk_call% dk_fixme "test dk_fixme message"
%dk_call% dk_warning "test dk_warning message"
%dk_call% dk_deprecated "test dk_deprecated message"
%dk_call% dk_error "test dk_error message"
%dk_call% dk_fatal "test dk_fatal message"
%endfunction%
