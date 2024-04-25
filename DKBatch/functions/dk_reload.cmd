::dk_includeGuard()

::####################################################################
::# dk_reload()
::#
::#
:dk_reload () {
	call dk_debugFunc
	
	if "%SCRIPT_PATH%" == "" dk_error "SCRIPT_PATH is invalid"; goto:eof
	
    echo .
    echo reloading %SCRIPT_PATH%
    start "" "%SCRIPT_PATH%"
    exit
goto:eof