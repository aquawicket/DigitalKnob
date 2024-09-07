@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

if not defined PAUSE_ON_EXIT set "PAUSE_ON_EXIT=0"
::################################################################################
::# dk_exit(exit_code)
::#
::#
:dk_exit
 setlocal
    call dk_debugFunc 0 1
    ::echo dk_exit %~1
	
    if "%exit_code%" equ "" set "exit_code=0"
	if ERRORLEVEL 1 set "exit_code=%errorlevel%"
    if "%errorlevel%" gtr "%exit_code%" set "exit_code=%errorlevel%"
    if "%~1" gtr "%exit_code%" set "exit_code=%~1"
    
    if "%PAUSE_ON_EXIT%" equ "1" %dk_call% dk_echo "*** PAUSE_ON_EXIT: exit_code:%exit_code% ***" && %dk_call% dk_pause "Press any key to exit . . ."
    
	::echo exit_code = %exit_code%
	::echo exit_code:%exit_code%
	::pause
    exit %exit_code%
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
    call dk_debugFunc 0
    
    ::%dk_call% dk_exit
    ::%dk_call% dk_exit 0
    %dk_call% dk_exit 13
%endfunction%
