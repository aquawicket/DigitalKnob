::dk_include_guard()

::####################################################################
::# dk_reload()
::#
::#
:dk_reload () {
	call dk_verbose "dk_reload(%*)"
	
	if "%SCRIPT_PATH%" == "" dk_error "SCRIPT_PATH is invalid"; goto:eof
	
    echo .
    echo reloading %SCRIPT_PATH%
    start "" "%SCRIPT_PATH%"
    exit
goto:eof