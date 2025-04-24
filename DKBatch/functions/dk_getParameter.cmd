<<<<<<< HEAD
@echo off
if not defined DKINIT call "!DKBATCH_FUNCTIONS_DIR_!DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::#################################################################################
::# dk_getParameter(NAME rtn_var)
::#
:dk_getParameter NAME rtn_var
<<<<<<< HEAD
	call dk_debugFunc 0 99
 setlocal
	
    :getParameter_loop
	if "%~1" == "%~3" (
=======
setlocal
	%dk_call% dk_debugFunc 0 99

	
    :getParameter_loop
	if "%~1" equ "%~3" (
>>>>>>> Development
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
<<<<<<< HEAD
	call dk_debugFunc 0
 setlocal
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
 
	call :TEST_getParameter ARG1 "some data" ARG3 INPUT "input value" some_data "more data"
!endfunction!


:TEST_getParameter ARG1 ARG2 ARG3 ARG4
<<<<<<< HEAD
	call dk_debugFunc 0 99
 setlocal
=======
setlocal
	%dk_call% dk_debugFunc 0 99

>>>>>>> Development
	
	!dk_call! dk_getParameter INPUT value %*
	!dk_call! dk_printVar value
	!DUMP_VARS!
%endfunction%