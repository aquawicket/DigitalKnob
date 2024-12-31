@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::#################################################################################
::# dk_getParameter(NAME rtn_var)
::#
:dk_getParameter NAME rtn_var
	%dk_call% dk_debugFunc 0 99
 setlocal
	
    :getParameter_loop
	if "%~1" == "%~3" (
		set "_value_=%~4"
		goto end_getParameter_loop
	)
    shift /3 
    goto getParameter_loop 
	:end_getParameter_loop

    endlocal & set "%2=%_value_%"

::DEBUG
::	%dk_call% dk_printVar %2
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	%dk_call% dk_debugFunc 0
 setlocal
 
	call :TEST_getParameter ARG1 "some data" ARG3 INPUT "input value" some_data "more data"
!endfunction!


:TEST_getParameter ARG1 ARG2 ARG3 ARG4
	%dk_call% dk_debugFunc 0 99
 setlocal
	
	!dk_call! dk_getParameter INPUT value %*
	!dk_call! dk_printVar value
	!DUMP_VARS!
%endfunction%