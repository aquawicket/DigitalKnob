@echo off
if not defined DKINIT call "!DKBATCH_FUNCTIONS_DIR_!DK.cmd" %~0 %*

::#################################################################################
::# dk_getOptionValue(OPTION)
::#
:dk_getOptionValue OPTION
	call dk_debugFunc 0 99
	echo dk_getOptionValue
 setlocal
	
    :getParameter_loop
	if "%~2" == "" (
		%return%
	)
	if "%~1" == "%~2" (
	
		::set "_value_=%~3"
		endlocal & set "%1=%~3"
		%return%
	)
    shift /2
    goto getParameter_loop 
	:end_getParameter_loop

    endlocal & set "%1=%_value_%"

::DEBUG
::	%dk_call% dk_printVar %2
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
 setlocal
 
	call :TEST_getOptionValue ARG1 "some data" ARG3 INPUT "input value" some_data "more data"
!endfunction!


:TEST_getOptionValue ARG1 ARG2 ARG3 ARG4
	call dk_debugFunc 0 99
 setlocal
	
	!dk_call! dk_getOptionValue INPUT %*
	!dk_call! dk_printVar INPUT
	!DUMP_VARS!
%endfunction%