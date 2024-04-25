::dk_includeGuard()

::####################################################################
::# dk_resetApps()
::#
::#
:dk_resetApps () {
	call dk_debugFunc
	
    echo Resetting Apps . . .

    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof

    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof