@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

::####################################################################
::# dk_resetApps()
::#
::#
:dk_resetApps
	call dk_debugFunc 0
	
    echo Resetting Apps . . .

	call dk_confirm || goto:eof
	
    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc 0
	
	call dk_resetApps
goto:eof
