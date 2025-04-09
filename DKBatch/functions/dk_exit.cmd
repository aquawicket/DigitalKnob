@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

if not defined PAUSE_ON_EXIT set "PAUSE_ON_EXIT=1"
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
    
    if "%PAUSE_ON_EXIT%" equ "1" %dk_call% dk_echo "*** PAUSE_ON_EXIT: EXIT_CODE:%EXIT_CODE% ***" && %dk_call% dk_pause "Press any key to exit . . ."
    
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
