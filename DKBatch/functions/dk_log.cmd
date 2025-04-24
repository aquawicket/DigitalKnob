<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

if not defined ENABLE_dk_log   set "ENABLE_dk_log=1"

:: 0 VERBOSE    dk_verbose
:: 1 DEBUG      dk_debug
:: 2 INFO       dk_info
:: 3 SUCCESS    dk_success
:: 4 TODO       dk_todo
:: 5 NOTICE     dk_notice
:: 6 FIXME      dk_fixme
:: 7 WARNING    dk_warning
:: 8 ERROR      dk_error
:: 9 FATAL      dk_fatal
    
:: DEFAULT
if not defined DEFAULT_ENABLE  set "DEFAULT_ENABLE=1"
if not defined DEFAULT_COLOR   set "DEFAULT_COLOR=%white%"
::if not defined DEFAULT_TAG     set "DEFAULT_TAG="
::if not defined DEFAULT_PAUSE   set "DEFAULT_PAUSE=0"
::if not defined DEFAULT_TRACE   set "DEFAULT_TRACE=0"
::if not defined DEFAULT_LINE    set "DEFAULT_LINE=0"
::if not defined DEFAULT_HALT    set "DEFAULT_HALT=0"

:: VERBOSE
if not defined VERBOSE_ENABLE  set "VERBOSE_ENABLE=1"
if not defined VERBOSE_COLOR   set "VERBOSE_COLOR=%magenta%"
if not defined VERBOSE_TAG     set "VERBOSE_TAG=VERBOSE: "
::if not defined VERBOSE_PAUSE   set "VERBOSE_PAUSE=0"
::if not defined VERBOSE_TRACE   set "VERBOSE_TRACE=0"
::if not defined VERBOSE_LINE    set "VERBOSE_LINE=0"
::if not defined VERBOSE_HALT    set "VERBOSE_HALT=0"

:: DEBUG
if not defined DEBUG_ENABLE    set "DEBUG_ENABLE=1"
if not defined DEBUG_COLOR     set "DEBUG_COLOR=%lblue%"
if not defined DEBUG_TAG       set "DEBUG_TAG=DEBUG: "
::if not defined DEBUG_PAUSE     set "DEBUG_PAUSE=0"
::if not defined DEBUG_TRACE     set "DEBUG_TRACE=0"
::if not defined DEBUG_LINE      set "DEBUG_LINE=0"
::if not defined DEBUG_HALT      set "DEBUG_HALT=0"

:: INFO
if not defined INFO_ENABLE     set "INFO_ENABLE=1"
if not defined INFO_COLOR      set "INFO_COLOR=%white%"
if not defined INFO_TAG        set "INFO_TAG=INFO: "
::if not defined INFO_PAUSE      set "INFO_PAUSE=0"
::if not defined INFO_TRACE      set "INFO_TRACE=0"
::if not defined INFO_LINE       set "INFO_LINE=0"
::if not defined INFO_HALT       set "INFO_HALT=0"

:: SUCCESS
if not defined SUCCESS_ENABLE   set "SUCCESS_ENABLE=1"
if not defined SUCCESS_COLOR    set "SUCCESS_COLOR=%green%"
if not defined SUCCESS_TAG      set "SUCCESS_TAG=SUCCESS: "
::if not defined SUCCESS_PAUSE    set "SUCCESS_PAUSE=0"
::if not defined SUCCESS_TRACE    set "SUCCESS_TRACE=0"
::if not defined SUCCESS_LINE     set "SUCCESS_LINE=0"
::if not defined SUCCESS_HALT     set "SUCCESS_HALT=0"

:: TODO
if not defined TODO_ENABLE     set "TODO_ENABLE=1"
if not defined TODO_COLOR      set "TODO_COLOR=%blue%"
if not defined TODO_TAG        set "TODO_TAG=TODO: "
if not defined TODO_PAUSE      set "TODO_PAUSE=1"
::if not defined TODO_TRACE      set "TODO_TRACE=0"
::if not defined TODO_LINE       set "TODO_LINE=0"
::if not defined TODO_HALT       set "TODO_HALT=0"

:: NOTICE
if not defined NOTICE_ENABLE   set "NOTICE_ENABLE=1"
if not defined NOTICE_COLOR    set "NOTICE_COLOR=%lyellow%"
if not defined NOTICE_TAG      set "NOTICE_TAG=NOTICE: "
::if not defined NOTICE_PAUSE    set "NOTICE_PAUSE=0"
::if not defined NOTICE_TRACE    set "NOTICE_TRACE=0"
::if not defined NOTICE_LINE     set "NOTICE_LINE=0"
::if not defined NOTICE_HALT     set "NOTICE_HALT=0"

:: FIXME
if not defined FIXME_ENABLE    set "FIXME_ENABLE=1"
if not defined FIXME_COLOR     set "FIXME_COLOR=%lyellow%"
if not defined FIXME_TAG       set "FIXME_TAG=FIXME: "
if not defined FIXME_PAUSE     set "FIXME_PAUSE=1"
::if not defined FIXME_TRACE     set "FIXME_TRACE=0"
::if not defined FIXME_LINE      set "FIXME_LINE=0"
::if not defined FIXME_HALT      set "FIXME_HALT=0"

:: WARNING
if not defined WARNING_ENABLE  set "WARNING_ENABLE=1"
if not defined WARNING_COLOR   set "WARNING_COLOR=%yellow%"
if not defined WARNING_TAG     set "WARNING_TAG=WARNING: "
::if not defined WARNING_PAUSE   set "WARNING_PAUSE=0"
::if not defined WARNING_TRACE   set "WARNING_TRACE=0"
::if not defined WARNING_LINE    set "WARNING_LINE=0"
::if not defined WARNING_HALT    set "WARNING_HALT=0"

:: ERROR
if not defined ERROR_ENABLE    set "ERROR_ENABLE=1"
if not defined ERROR_COLOR     set "ERROR_COLOR=%lred%"
if not defined ERROR_TAG       set "ERROR_TAG=ERROR: "
if not defined ERROR_PAUSE     set "ERROR_PAUSE=1"
::if not defined ERROR_TRACE     set "ERROR_TRACE=0"
::if not defined ERROR_LINE      set "ERROR_LINE=0"
::if not defined ERROR_HALT      set "ERROR_HALT=1"

:: FATAL
if not defined FATAL_ENABLE    set "FATAL_ENABLE=1"
if not defined FATAL_COLOR     set "FATAL_COLOR=%red%"
if not defined FATAL_TAG       set "FATAL_TAG=FATAL: "
if not defined FATAL_PAUSE     set "FATAL_PAUSE=1"
::if not defined FATAL_TRACE     set "FATAL_TRACE=0"
::if not defined FATAL_LINE      set "FATAL_LINE=0"
if not defined FATAL_HALT      set "FATAL_HALT=1"
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


if not defined dk_log_ENABLE	(set "dk_log_ENABLE=1")

::###### level order ######
::#		0 VERBOSE		dk_verbose
::#		1 DEBUG			dk_debug
::#		  DEFAULT		dk_default
::#		2 INFO			dk_info
::#		3 SUCCESS		dk_success
::#		4 TODO			dk_todo
::#		5 NOTICE		dk_notice
::#		6 FIXME			dk_fixme
::#		7 WARNING		dk_warning
::#		8 DEPRECATED	dk_deprecated
::#		9 ERROR			dk_error
::#    10 FATAL			dk_fatal

::###### option order ######
::# 	ENABLE
::# 	COLOR
::# 	TAG
::# 	TRACE
::# 	LINE
::# 	SOUND
::# 	TIMEOUT
::# 	PAUSE
::# 	HALT

::### VERBOSE ###
if not defined dk_log_VERBOSE_ENABLE		(set "dk_log_VERBOSE_ENABLE=1")
if not defined dk_log_VERBOSE_COLOR			(set "dk_log_VERBOSE_COLOR=%magenta%")
if not defined dk_log_VERBOSE_TAG			(set "dk_log_VERBOSE_TAG=VERBOSE: ")
::if not defined dk_log_VERBOSE_TRACE		(set "dk_log_VERBOSE_TRACE=0")
::if not defined dk_log_VERBOSE_LINE		(set "dk_log_VERBOSE_LINE=0")
::if not defined dk_log_VERBOSE_SOUND		(set "dk_log_VERBOSE_SOUND=0")
::if not defined dk_log_VERBOSE_TIMEOUT 	(set "dk_log_VERBOSE_TIMEOUT=0")
::if not defined dk_log_VERBOSE_PAUSE		(set "dk_log_VERBOSE_PAUSE=0")
::if not defined dk_log_VERBOSE_HALT		(set "dk_log_VERBOSE_HALT=0")

::### DEBUG ###
if not defined dk_log_DEBUG_ENABLE			(set "dk_log_DEBUG_ENABLE=1")
if not defined dk_log_DEBUG_COLOR			(set "dk_log_DEBUG_COLOR=%lblue%")
if not defined dk_log_DEBUG_TAG				(set "dk_log_DEBUG_TAG=DEBUG: ")
::if not defined dk_log_DEBUG_TRACE			(set "dk_log_DEBUG_TRACE=0")
::if not defined dk_log_DEBUG_LINE			(set "dk_log_DEBUG_LINE=0")
::if not defined dk_log_DEBUG_SOUND			(set "dk_log_DEBUG_SOUND=0")
::if not defined dk_log_DEBUG_TIMEOUT		(set "dk_log_DEBUG_TIMEOUT=0")
::if not defined dk_log_DEBUG_PAUSE			(set "dk_log_DEBUG_PAUSE=0")
::if not defined dk_log_DEBUG_HALT			(set "dk_log_DEBUG_HALT=0")

::### DEFAULT ###
if not defined dk_log_DEFAULT_ENABLE		(set "dk_log_DEFAULT_ENABLE=1")
if not defined dk_log_DEFAULT_COLOR			(set "dk_log_DEFAULT_COLOR=%white%")
::if not defined dk_log_DEFAULT_TAG			(set "dk_log_DEFAULT_TAG=")
::if not defined dk_log_DEFAULT_TRACE		(set "dk_log_DEFAULT_TRACE=0")
::if not defined dk_log_DEFAULT_LINE		(set "dk_log_DEFAULT_LINE=0")
::if not defined dk_log_DEFAULT_SOUND		(set "dk_log_DEFAULT_SOUND=0")
::if not defined dk_log_DEFAULT_TIMEOUT		(set "dk_log_DEFAULT_TIMEOUT=0")
::if not defined dk_log_DEFAULT_PAUSE		(set "dk_log_DEFAULT_PAUSE=0")
::if not defined dk_log_DEFAULT_HALT		(set "dk_log_DEFAULT_HALT=0")

::### INFO ###
if not defined dk_log_INFO_ENABLE			(set "dk_log_INFO_ENABLE=1")
if not defined dk_log_INFO_COLOR			(set "dk_log_INFO_COLOR=%white%")
if not defined dk_log_INFO_TAG				(set "dk_log_INFO_TAG=INFO: ")
::if not defined dk_log_INFO_TRACE			(set "dk_log_INFO_TRACE=0")
::if not defined dk_log_INFO_LINE			(set "dk_log_INFO_LINE=0")
::if not defined dk_log_INFO_SOUND			(set "dk_log_INFO_SOUND=0")
::if not defined dk_log_INFO_TIMEOUT		(set "dk_log_INFO_TIMEOUT=0")
::if not defined dk_log_INFO_PAUSE			(set "dk_log_INFO_PAUSE=0")
::if not defined dk_log_INFO_HALT			(set "dk_log_INFO_HALT=0")

::### SUCCESS ###
if not defined dk_log_SUCCESS_ENABLE		(set "dk_log_SUCCESS_ENABLE=1")
if not defined dk_log_SUCCESS_COLOR			(set "dk_log_SUCCESS_COLOR=%green%")
if not defined dk_log_SUCCESS_TAG			(set "dk_log_SUCCESS_TAG=SUCCESS: ")
::if not defined dk_log_SUCCESS_TRACE		(set "dk_log_SUCCESS_TRACE=0")
::if not defined dk_log_SUCCESS_LINE		(set "dk_log_SUCCESS_LINE=0")
::if not defined dk_log_SUCCESS_SOUND		(set "dk_log_SUCCESS_SOUND=0")
::if not defined dk_log_SUCCESS_TIMEOUT		(set "dk_log_SUCCESS_TIMEOUT=0")
::if not defined dk_log_SUCCESS_PAUSE		(set "dk_log_SUCCESS_PAUSE=0")
::if not defined dk_log_SUCCESS_HALT		(set "dk_log_SUCCESS_HALT=0")

::### TODO ###
if not defined dk_log_TODO_ENABLE			(set "dk_log_TODO_ENABLE=1")
if not defined dk_log_TODO_COLOR			(set "dk_log_TODO_COLOR=%blue%")
if not defined dk_log_TODO_TAG				(set "dk_log_TODO_TAG=TODO: ")
::if not defined dk_log_TODO_TRACE			(set "dk_log_TODO_TRACE=0")
::if not defined dk_log_TODO_LINE			(set "dk_log_TODO_LINE=0")
::if not defined dk_log_TODO_SOUND			(set "dk_log_TODO_SOUND=0")
if not defined dk_log_TODO_TIMEOUT			(set "dk_log_TODO_TIMEOUT=1")
::if not defined dk_log_TODO_PAUSE			(set "dk_log_TODO_PAUSE=0")
::if not defined dk_log_TODO_HALT			(set "dk_log_TODO_HALT=0")

::### NOTICE ###
if not defined dk_log_NOTICE_ENABLE			(set "dk_log_NOTICE_ENABLE=1")
if not defined dk_log_NOTICE_COLOR			(set "dk_log_NOTICE_COLOR=%lyellow%")
if not defined dk_log_NOTICE_TAG			(set "dk_log_NOTICE_TAG=NOTICE: ")
::if not defined dk_log_NOTICE_TRACE		(set "dk_log_NOTICE_TRACE=0")
::if not defined dk_log_NOTICE_LINE			(set "dk_log_NOTICE_LINE=0")
::if not defined dk_log_NOTICE_SOUND		(set "dk_log_NOTICE_SOUND=0")
::if not defined dk_log_NOTICE_TIMEOUT		(set "dk_log_NOTICE_TIMEOUT=0")
::if not defined dk_log_NOTICE_PAUSE		(set "dk_log_NOTICE_PAUSE=0")
::if not defined dk_log_NOTICE_HALT			(set "dk_log_NOTICE_HALT=0")

::### FIXME ###
if not defined dk_log_FIXME_ENABLE			(set "dk_log_FIXME_ENABLE=1")
if not defined dk_log_FIXME_COLOR			(set "dk_log_FIXME_COLOR=%lyellow%")
if not defined dk_log_FIXME_TAG				(set "dk_log_FIXME_TAG=FIXME: ")
::if not defined dk_log_FIXME_TRACE			(set "dk_log_FIXME_TRACE=0")
::if not defined dk_log_FIXME_LINE			(set "dk_log_FIXME_LINE=0")
::if not defined dk_log_FIXME_SOUND			(set "dk_log_FIXME_SOUND=0")
if not defined dk_log_FIXME_TIMEOUT			(set "dk_log_FIXME_TIMEOUT=3")
::if not defined dk_log_FIXME_PAUSE			(set "dk_log_FIXME_PAUSE=0")
::if not defined dk_log_FIXME_HALT			(set "dk_log_FIXME_HALT=0")

::### WARNING ###
if not defined dk_log_WARNING_ENABLE		(set "dk_log_WARNING_ENABLE=1")
if not defined dk_log_WARNING_COLOR			(set "dk_log_WARNING_COLOR=%yellow%")
if not defined dk_log_WARNING_TAG			(set "dk_log_WARNING_TAG=WARNING: ")
if not defined dk_log_WARNING_TRACE			(set "dk_log_WARNING_TRACE=1")
::if not defined dk_log_WARNING_LINE		(set "dk_log_WARNING_LINE=0")
::if not defined dk_log_WARNING_SOUND		(set "dk_log_WARNING_SOUND=0")
::if not defined dk_log_WARNING_TIMEOUT		(set "dk_log_WARNING_TIMEOUT=0")
::if not defined dk_log_WARNING_PAUSE		(set "dk_log_WARNING_PAUSE=0")
::if not defined dk_log_WARNING_HALT		(set "dk_log_WARNING_HALT=0")

::### DEPRECATED ###
if not defined dk_log_DEPRECATED_ENABLE		(set "dk_log_DEPRECATED_ENABLE=1")
if not defined dk_log_DEPRECATED_COLOR		(set "dk_log_DEPRECATED_COLOR=%dim%%yellow%")
if not defined dk_log_DEPRECATED_TAG		(set "dk_log_DEPRECATED_TAG=DEPRECATED: ")
if not defined dk_log_DEPRECATED_TRACE		(set "dk_log_DEPRECATED_TRACE=1")
::if not defined dk_log_DEPRECATED_LINE		(set "dk_log_DEPRECATED_LINE=0")
::if not defined dk_log_DEPRECATED_SOUND	(set "dk_log_DEPRECATED_SOUND=0")
if not defined dk_log_DEPRECATED_TIMEOUT	(set "dk_log_DEPRECATED_TIMEOUT=3")
::if not defined dk_log_DEPRECATED_PAUSE	(set "dk_log_DEPRECATED_PAUSE=0")
::if not defined dk_log_DEPRECATED_HALT		(set "dk_log_DEPRECATED_HALT=0")

::### ERROR ###
if not defined dk_log_ERROR_ENABLE			(set "dk_log_ERROR_ENABLE=1")
if not defined dk_log_ERROR_COLOR			(set "dk_log_ERROR_COLOR=%lred%")
if not defined dk_log_ERROR_TAG				(set "dk_log_ERROR_TAG=ERROR: ")
if not defined dk_log_ERROR_TRACE			(set "dk_log_ERROR_TRACE=1")
::if not defined dk_log_ERROR_LINE			(set "dk_log_ERROR_LINE=0")
::if not defined dk_log_ERROR_SOUND			(set "dk_log_ERROR_SOUND=0")
if not defined dk_log_ERROR_TIMEOUT			(set "dk_log_ERROR_TIMEOUT=3")
::if not defined dk_log_ERROR_PAUSE			(set "dk_log_ERROR_PAUSE=0")
::if not defined dk_log_ERROR_HALT			(set "dk_log_ERROR_HALT=0")

::### FATAL ###
if not defined dk_log_FATAL_ENABLE			(set "dk_log_FATAL_ENABLE=1")
if not defined dk_log_FATAL_COLOR			(set "dk_log_FATAL_COLOR=%red%")
if not defined dk_log_FATAL_TAG				(set "dk_log_FATAL_TAG=FATAL: ")
if not defined dk_log_FATAL_TRACE			(set "dk_log_FATAL_TRACE=1")
::if not defined dk_log_FATAL_LINE			(set "dk_log_FATAL_LINE=0")
::if not defined dk_log_FATAL_SOUND			(set "dk_log_FATAL_SOUND=0")
if not defined dk_log_FATAL_TIMEOUT			(set "dk_log_FATAL_TIMEOUT=9")
::if not defined dk_log_FATAL_PAUSE			(set "dk_log_FATAL_PAUSE=0")
::if not defined dk_log_FATAL_HALT			(set "dk_log_FATAL_HALT=0")
>>>>>>> Development



::##################################################################################
::# dk_log(<level> <message>)
::#
<<<<<<< HEAD
::#    Print a log message to the console
::#
::#    @level   - The message level
::#    @message - The message to print
::#
:dk_log
    call dk_debugFunc 1 2
    if "%ENABLE_dk_log%" neq "1"  %return%
  setlocal   
    
        if "%~2" equ "" set "_level_=DEFAULT" && set "_message_=%~1"
        if "%~2" neq "" set "_level_=%~1"     && set "_message_=%~2"
        if "!%_level_%_ENABLE!" neq "1"  %return%
      
        ::if "" == %_message_:~0,1%%_message_:~-1% %dk_call% dk_set _message_ %_message_:~1,-1%    &:: if _message_ starts and ends with quotes, remove them

        %dk_call% dk_echo "!%_level_%_COLOR!!%_level_%_TAG!%_message_%%clr%"
        if "!%_level_%_TRACE!"=="1" %dk_call% dk_echo "!%_level_%_COLOR!*** TRACE_ON_%_level_% ***%clr%"  && %dk_call% dk_stacktrace
        if "!%_level_%_LINE!"=="1"  %dk_call% dk_echo "!%_level_%_COLOR!*** LINE_ON_%_level_% ***%crl%"   && %dk_call% dk_showFileLine "%_callerpath%" "%_message_%"
		if "!%_level_%_PAUSE!"=="1" %dk_call% dk_echo "!%_level_%_COLOR!*** PAUSE_ON_%_level_% ***%clr%"  && %dk_call% dk_pause
        if "!%_level_%_HALT!"=="1"  %dk_call% dk_echo "!%_level_%_COLOR!*** HALT_ON_%_level_% ***%clr%"   && %dk_call% dk_exit 13
=======
::#		Print a log message to the console
::#
::#		@level   - The message level: VERBOSE, DEBUG, DEFAULT, INFO, SUCCESS, TODO, NOTICE, FIXME, WARNING, ERROR, FATAL 
::#		@message - The message to print
::#
:dk_log
setlocal enableDelayedExpansion
	%dk_call% dk_debugFunc 1 2

	if "%dk_log_ENABLE%" neq "1" (
		%return%
	)

	if "%~2" equ "" (
		set "_level_=DEFAULT"
		set "_message_=%~1"
	)
	
	if "%~2" neq "" (
		set "_level_=%~1"
		set "_message_=%~2"
	)
	
	if "!dk_log_%_level_%_ENABLE!" neq "1" (
		%return%
	)

	::### remove surrounding quotes ###
	::if "" == %_message_:~0,1%%_message_:~-1% (
	::	%dk_call% dk_set _message_ %_message_:~1,-1%	&rem if _message_ starts and ends with quotes, remove them
	::)

	::###### ECHO MESSAGE ######
	%dk_call% dk_echo "!dk_log_%_level_%_COLOR!!dk_log_%_level_%_TAG!%_message_%%clr%"

	::###### TRACE ######
	if "!dk_log_%_level_%_TRACE!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** TRACE_ON_%_level_% ***"
		%dk_call% dk_stacktrace
		%dk_call% dk_echo "%clr%"
	)

	::###### LINE ######
	if "!dk_log_%_level_%_LINE!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** LINE_ON_%_level_% ***"
		%dk_call% dk_showFileLine "%_callerpath%" "%_message_%"
		%dk_call% dk_echo "%clr%"
	)

	::###### SOUND ######
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
		
	::###### TIMEOUT ######
	if "!dk_log_%_level_%_TIMEOUT!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** TIMEOUT_ON_%_level_% ***"
		%dk_call% dk_timeout !dk_log_%_level_%_TIMEOUT!
		%dk_call% dk_echo "%clr%"
	)
	
	::###### PAUSE ######
	if "!dk_log_%_level_%_PAUSE!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** PAUSE_ON_%_level_% ***"
		%dk_call% dk_pause
		%dk_call% dk_echo "%clr%"
	)
	
	::###### HALT ######
	if "!dk_log_%_level_%_HALT!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** HALT_ON_%_level_% ***"
		%dk_call% dk_exit 13
		%dk_call% dk_echo "%clr%"
	)

>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
    
    %dk_call% dk_log "test dk_log message"
    
    %dk_call% dk_log VERBOSE "test dk_log VERBOSE message"
    %dk_call% dk_log DEBUG   "test dk_log DEBUG message"
    %dk_call% dk_log INFO    "test dk_log INFO message"
    %dk_call% dk_log SUCCESS "test dk_log SUCCESS message"
    %dk_call% dk_log TODO    "test dk_log TODO message"
    %dk_call% dk_log NOTICE  "test dk_log NOTICE message"
    %dk_call% dk_log FIXME   "test dk_log FIXME message"
    %dk_call% dk_log WARNING "test dk_log WARNING message"
    %dk_call% dk_log ERROR   "test dk_log ERROR message"
    %dk_call% dk_log FATAL   "test dk_log FATAL message"
=======
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_log VERBOSE	"test dk_log VERBOSE message"
	%dk_call% dk_log DEBUG		"test dk_log DEBUG message"
	%dk_call% dk_log			"test dk_log message"
	%dk_call% dk_log INFO		"test dk_log INFO message"
	%dk_call% dk_log SUCCESS	"test dk_log SUCCESS message"
	%dk_call% dk_log TODO		"test dk_log TODO message"
	%dk_call% dk_log NOTICE		"test dk_log NOTICE message"
	%dk_call% dk_log FIXME		"test dk_log FIXME message"
	%dk_call% dk_log WARNING	"test dk_log WARNING message"
	%dk_call% dk_log DEPRECATED	"test dk_log DEPRECATED message"
	%dk_call% dk_log ERROR		"test dk_log ERROR message"
	%dk_call% dk_log FATAL		"test dk_log FATAL message"
>>>>>>> Development
%endfunction%
