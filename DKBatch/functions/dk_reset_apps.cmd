::dk_include_guard()

::####################################################################
::# dk_reset_apps()
::#
::#
:dk_reset_apps () {
	call dk_verbose "dk_reset_apps(%*)"
	
    echo Resetting Apps . . .

    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof

    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof