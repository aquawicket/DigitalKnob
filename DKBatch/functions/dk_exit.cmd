@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

if not defined PAUSE_ON_EXIT set "PAUSE_ON_EXIT=1"
::################################################################################
::# dk_exit()
::#
::#
:dk_exit
	call dk_debugFunc 0 1
	
	if "%PAUSE_ON_EXIT%" == "1" call dk_echo "*** PAUSE_ON_EXIT ***" && call dk_pause
	exit %~1
goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_exit 0
goto:eof
