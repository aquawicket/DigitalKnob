@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

if not defined dk_exit_PAUSE set "dk_exit_PAUSE=1"
::################################################################################
::# dk_exit(exit_code)
::#
::#
:dk_exit
::setlocal
	%dk_call% dk_debugFunc 0 1
 
	if "%~1" gtr "%EXIT_CODE%" %dk_call% dk_set EXIT_CODE %~1
	
    ::if "%EXIT_CODE%" equ "" set "EXIT_CODE=0"
	if ERRORLEVEL 1 set "EXIT_CODE=%errorlevel%"
    if "%errorlevel%" gtr "%EXIT_CODE%" set "EXIT_CODE=%errorlevel%"
    if "%~1" gtr "%EXIT_CODE%" set "EXIT_CODE=%~1"
    
    if "%dk_exit_PAUSE%" equ "1" %dk_call% dk_echo "*** dk_exit_PAUSE: EXIT_CODE:%EXIT_CODE% ***" && %dk_call% dk_pause "Press any key to exit . . ."
    
    exit %EXIT_CODE%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    ::%dk_call% dk_exit
    ::%dk_call% dk_exit 0
    %dk_call% dk_exit 13
%endfunction%
