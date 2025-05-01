@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::#################### dk_exit settings ##########################################
if not defined dk_exit_PAUSE_ON_EXIT 	(set "dk_exit_PAUSE_ON_EXIT=0")
if not defined dk_exit_PAUSE_ON_ERROR	(set "dk_exit_PAUSE_ON_ERROR=1")
::################################################################################
::# dk_exit(exit_code)
::#
::#
:dk_exit
%setlocal%
	%dk_call% dk_debugFunc 0 1
 
	if "%~1" neq "%exit_code%" 			(%dk_call% dk_set exit_code %~1)
	if ERRORLEVEL 1 					(set "exit_code=%errorlevel%")
    if "%errorlevel%" gtr "%exit_code%" (set "exit_code=%errorlevel%")
    if "%~1" gtr "%exit_code%" 			(set "exit_code=%~1")
    
    if "%dk_exit_PAUSE_ON_EXIT%" equ "1" (
		%dk_call% dk_echo "*** dk_exit_PAUSE_ON_EXIT ***"
		set "PAUSE=1"
	)
	if "%dk_exit_PAUSE_ON_ERROR%" equ "1" (
		if "%exit_code%" neq "0" (
			%dk_call% dk_echo "*** dk_exit_PAUSE_ON_ERROR ***"
			set "PAUSE=1"
		)
	)
	
	%dk_call% dk_echo "exit_code:%exit_code%"
	
	if "%PAUSE%" equ "1" (
		%dk_call% dk_pause "Press any key to exit . . ."
	)
    exit %exit_code%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    ::%dk_call% dk_exit
    ::%dk_call% dk_exit 0
    %dk_call% dk_exit 13
%endfunction%
