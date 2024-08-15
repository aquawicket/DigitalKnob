@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

if not defined PAUSE_ON_EXIT set "PAUSE_ON_EXIT=1"
::################################################################################
::# dk_exit(exit_code)
::#
::#
:dk_exit
	call dk_debugFunc 0 1
	
	if "%exit_code%" equ "" set "exit_code=0"
	if %errorlevel% gtr %exit_code% set "exit_code=%errorlevel%"
	if %~1 gtr %exit_code% set "exit_code=%~1"
	
	if "%PAUSE_ON_EXIT%" == "1" %dk_call% dk_echo "*** PAUSE_ON_EXIT: exit_code:%exit_code% ***" && %dk_call% dk_pause
	
	exit %exit_code%
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	::%dk_call% dk_exit
	::%dk_call% dk_exit 0
	%dk_call% dk_exit 13
goto:eof
