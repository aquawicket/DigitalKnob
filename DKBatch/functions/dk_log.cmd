@echo off
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

if not defined dk_log_ENABLE	(set "dk_log_ENABLE=1")

::	0 VERBOSE		dk_verbose
::	1 DEBUG			dk_debug
::	  DEFAULT		dk_default
::	2 INFO			dk_info
::	3 SUCCESS		dk_success
::	4 TODO			dk_todo
::	5 NOTICE		dk_notice
::	6 FIXME			dk_fixme
::	7 WARNING		dk_warning
::	8 DEPRECATED	dk_deprecated
::	9 ERROR			dk_error
:: 10 FATAL			dk_fatal

::### VERBOSE ###
if not defined dk_log_VERBOSE_ENABLE		(set "dk_log_VERBOSE_ENABLE=1")
if not defined dk_log_VERBOSE_COLOR			(set "dk_log_VERBOSE_COLOR=%magenta%")
if not defined dk_log_VERBOSE_TAG			(set "dk_log_VERBOSE_TAG=VERBOSE: ")
::if not defined dk_log_VERBOSE_TRACE		(set "dk_log_VERBOSE_TRACE=0")
::if not defined dk_log_VERBOSE_LINE		(set "dk_log_VERBOSE_LINE=0")
::if not defined dk_log_VERBOSE_PAUSE		(set "dk_log_VERBOSE_PAUSE=0")
::if not defined dk_log_VERBOSE_TIMEOUT 	(set "dk_log_VERBOSE_TIMEOUT=0")
::if not defined dk_log_VERBOSE_HALT		(set "dk_log_VERBOSE_HALT=0")

::### DEBUG ###
if not defined dk_log_DEBUG_ENABLE			(set "dk_log_DEBUG_ENABLE=1")
if not defined dk_log_DEBUG_COLOR			(set "dk_log_DEBUG_COLOR=%lblue%")
if not defined dk_log_DEBUG_TAG				(set "dk_log_DEBUG_TAG=DEBUG: ")
::if not defined dk_log_DEBUG_TRACE			(set "dk_log_DEBUG_TRACE=0")
::if not defined dk_log_DEBUG_LINE			(set "dk_log_DEBUG_LINE=0")
::if not defined dk_log_DEBUG_PAUSE			(set "dk_log_DEBUG_PAUSE=0")
::if not defined dk_log_DEBUG_TIMEOUT		(set "dk_log_DEBUG_TIMEOUT=0")
::if not defined dk_log_DEBUG_HALT			(set "dk_log_DEBUG_HALT=0")

::### DEFAULT ###
if not defined dk_log_DEFAULT_ENABLE		(set "dk_log_DEFAULT_ENABLE=1")
if not defined dk_log_DEFAULT_COLOR			(set "dk_log_DEFAULT_COLOR=%white%")
::if not defined dk_log_DEFAULT_TAG			(set "dk_log_DEFAULT_TAG=")
::if not defined dk_log_DEFAULT_TRACE		(set "dk_log_DEFAULT_TRACE=0")
::if not defined dk_log_DEFAULT_LINE		(set "dk_log_DEFAULT_LINE=0")
::if not defined dk_log_DEFAULT_PAUSE		(set "dk_log_DEFAULT_PAUSE=0")
::if not defined dk_log_DEFAULT_TIMEOUT		(set "dk_log_DEFAULT_TIMEOUT=0")
::if not defined dk_log_DEFAULT_HALT		(set "dk_log_DEFAULT_HALT=0")

::### INFO ###
if not defined dk_log_INFO_ENABLE			(set "dk_log_INFO_ENABLE=1")
if not defined dk_log_INFO_COLOR			(set "dk_log_INFO_COLOR=%white%")
if not defined dk_log_INFO_TAG				(set "dk_log_INFO_TAG=INFO: ")
::if not defined dk_log_INFO_TRACE			(set "dk_log_INFO_TRACE=0")
::if not defined dk_log_INFO_LINE			(set "dk_log_INFO_LINE=0")
::if not defined dk_log_INFO_PAUSE			(set "dk_log_INFO_PAUSE=0")
::if not defined dk_log_INFO_TIMEOUT		(set "dk_log_INFO_TIMEOUT=0")
::if not defined dk_log_INFO_HALT			(set "dk_log_INFO_HALT=0")

::### SUCCESS ###
if not defined dk_log_SUCCESS_ENABLE		(set "dk_log_SUCCESS_ENABLE=1")
if not defined dk_log_SUCCESS_COLOR			(set "dk_log_SUCCESS_COLOR=%green%")
if not defined dk_log_SUCCESS_TAG			(set "dk_log_SUCCESS_TAG=SUCCESS: ")
::if not defined dk_log_SUCCESS_TRACE		(set "dk_log_SUCCESS_TRACE=0")
::if not defined dk_log_SUCCESS_LINE		(set "dk_log_SUCCESS_LINE=0")
::if not defined dk_log_SUCCESS_PAUSE		(set "dk_log_SUCCESS_PAUSE=0")
::if not defined dk_log_SUCCESS_TIMEOUT		(set "dk_log_SUCCESS_TIMEOUT=0")
::if not defined dk_log_SUCCESS_HALT		(set "dk_log_SUCCESS_HALT=0")

::### TODO ###
if not defined dk_log_TODO_ENABLE			(set "dk_log_TODO_ENABLE=1")
if not defined dk_log_TODO_COLOR			(set "dk_log_TODO_COLOR=%blue%")
if not defined dk_log_TODO_TAG				(set "dk_log_TODO_TAG=TODO: ")
::if not defined dk_log_TODO_TRACE			(set "dk_log_TODO_TRACE=0")
::if not defined dk_log_TODO_LINE			(set "dk_log_TODO_LINE=0")
::if not defined dk_log_TODO_PAUSE			(set "dk_log_TODO_PAUSE=0")
if not defined dk_log_TODO_TIMEOUT			(set "dk_log_TODO_TIMEOUT=1")
::if not defined dk_log_TODO_HALT			(set "dk_log_TODO_HALT=0")

::### NOTICE ###
if not defined dk_log_NOTICE_ENABLE			(set "dk_log_NOTICE_ENABLE=1")
if not defined dk_log_NOTICE_COLOR			(set "dk_log_NOTICE_COLOR=%lyellow%")
if not defined dk_log_NOTICE_TAG			(set "dk_log_NOTICE_TAG=NOTICE: ")
::if not defined dk_log_NOTICE_TRACE		(set "dk_log_NOTICE_TRACE=0")
::if not defined dk_log_NOTICE_LINE			(set "dk_log_NOTICE_LINE=0")
::if not defined dk_log_NOTICE_PAUSE		(set "dk_log_NOTICE_PAUSE=0")
::if not defined dk_log_NOTICE_TIMEOUT		(set "dk_log_NOTICE_TIMEOUT=0")
::if not defined dk_log_NOTICE_HALT			(set "dk_log_NOTICE_HALT=0")

::### FIXME ###
if not defined dk_log_FIXME_ENABLE			(set "dk_log_FIXME_ENABLE=1")
if not defined dk_log_FIXME_COLOR			(set "dk_log_FIXME_COLOR=%lyellow%")
if not defined dk_log_FIXME_TAG				(set "dk_log_FIXME_TAG=FIXME: ")
::if not defined dk_log_FIXME_TRACE			(set "dk_log_FIXME_TRACE=0")
::if not defined dk_log_FIXME_LINE			(set "dk_log_FIXME_LINE=0")
if not defined dk_log_FIXME_PAUSE			(set "dk_log_FIXME_PAUSE=1")
::if not defined dk_log_FIXME_TIMEOUT		(set "dk_log_FIXME_TIMEOUT=0")
::if not defined dk_log_FIXME_HALT			(set "dk_log_FIXME_HALT=0")

::### WARNING ###
if not defined dk_log_WARNING_ENABLE		(set "dk_log_WARNING_ENABLE=1")
if not defined dk_log_WARNING_COLOR			(set "dk_log_WARNING_COLOR=%yellow%")
if not defined dk_log_WARNING_TAG			(set "dk_log_WARNING_TAG=WARNING: ")
if not defined dk_log_WARNING_TRACE			(set "dk_log_WARNING_TRACE=1")
::if not defined dk_log_WARNING_LINE		(set "dk_log_WARNING_LINE=0")
::if not defined dk_log_WARNING_SOUND		(set "dk_log_WARNING_SOUND=0")
::if not defined dk_log_WARNING_PAUSE		(set "dk_log_WARNING_PAUSE=0")
::if not defined dk_log_WARNING_TIMEOUT		(set "dk_log_WARNING_TIMEOUT=0")
::if not defined dk_log_WARNING_HALT		(set "dk_log_WARNING_HALT=0")

::### DEPRECATED ###
if not defined dk_log_DEPRECATED_ENABLE		(set "dk_log_DEPRECATED_ENABLE=1")
if not defined dk_log_DEPRECATED_COLOR		(set "dk_log_DEPRECATED_COLOR=%dim%%yellow%")
if not defined dk_log_DEPRECATED_TAG		(set "dk_log_DEPRECATED_TAG=DEPRECATED: ")
if not defined dk_log_DEPRECATED_TRACE		(set "dk_log_DEPRECATED_TRACE=1")
::if not defined dk_log_DEPRECATED_LINE		(set "dk_log_DEPRECATED_LINE=0")
::if not defined dk_log_DEPRECATED_SOUND	(set "dk_log_DEPRECATED_SOUND=0")
if not defined dk_log_DEPRECATED_PAUSE		(set "dk_log_DEPRECATED_PAUSE=1")
::if not defined dk_log_DEPRECATED_TIMEOUT	(set "dk_log_DEPRECATED_TIMEOUT=0")
::if not defined dk_log_DEPRECATED_HALT		(set "dk_log_DEPRECATED_HALT=0")

::### ERROR ###
if not defined dk_log_ERROR_ENABLE			(set "dk_log_ERROR_ENABLE=1")
if not defined dk_log_ERROR_COLOR			(set "dk_log_ERROR_COLOR=%lred%")
if not defined dk_log_ERROR_TAG				(set "dk_log_ERROR_TAG=ERROR: ")
if not defined dk_log_ERROR_TRACE			(set "dk_log_ERROR_TRACE=1")
::if not defined dk_log_ERROR_LINE			(set "dk_log_ERROR_LINE=0")
::if not defined dk_log_ERROR_SOUND			(set "dk_log_ERROR_SOUND=0")
::if not defined dk_log_ERROR_PAUSE			(set "dk_log_ERROR_PAUSE=0")
if not defined dk_log_ERROR_TIMEOUT			(set "dk_log_ERROR_TIMEOUT=3")
::if not defined dk_log_ERROR_HALT			(set "dk_log_ERROR_HALT=0")

::### FATAL ###
if not defined dk_log_FATAL_ENABLE			(set "dk_log_FATAL_ENABLE=1")
if not defined dk_log_FATAL_COLOR			(set "dk_log_FATAL_COLOR=%red%")
if not defined dk_log_FATAL_TAG				(set "dk_log_FATAL_TAG=FATAL: ")
if not defined dk_log_FATAL_TRACE			(set "dk_log_FATAL_TRACE=1")
::if not defined dk_log_FATAL_LINE			(set "dk_log_FATAL_LINE=0")
::if not defined dk_log_FATAL_SOUND			(set "dk_log_FATAL_SOUND=0")
::if not defined dk_log_FATAL_PAUSE			(set "dk_log_FATAL_PAUSE=0")
if not defined dk_log_FATAL_TIMEOUT			(set "dk_log_FATAL_TIMEOUT=9")
::if not defined dk_log_FATAL_HALT			(set "dk_log_FATAL_HALT=0")



::##################################################################################
::# dk_log(<level> <message>)
::#
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

	::###### ECHO MASSAGE ######
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
		
	::###### PAUSE ######
	if "!dk_log_%_level_%_PAUSE!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** PAUSE_ON_%_level_% ***"
		%dk_call% dk_pause
		%dk_call% dk_echo "%clr%"
	)
	
	::###### TIMEOUT ######
	if "!dk_log_%_level_%_TIMEOUT!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** TIMEOUT_ON_%_level_% ***"
		%dk_call% dk_timeout !dk_log_%_level_%_TIMEOUT!
		%dk_call% dk_echo "%clr%"
	)
	
	::###### HALT ######
	if "!dk_log_%_level_%_HALT!" gtr "0" (
		%dk_call% dk_echo "!dk_log_%_level_%_COLOR!*** HALT_ON_%_level_% ***"
		%dk_call% dk_exit 13
		%dk_call% dk_echo "%clr%"
	)

%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
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
%endfunction%
