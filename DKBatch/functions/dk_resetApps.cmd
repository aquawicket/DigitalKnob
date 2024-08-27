@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_resetApps()
::#
::#
:dk_resetApps
 setlocal
	call dk_debugFunc 0
	
    echo Resetting Apps . . .

	%dk_call% dk_confirm || goto:eof
	
    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
 setlocal
	call dk_debugFunc 0
	
	%dk_call% dk_resetApps
goto:eof
