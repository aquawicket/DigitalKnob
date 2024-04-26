call dk_includeGuard

::####################################################################
::# dk_reload()
::#
::#
:dk_reload () {
	call dk_debugFunc
	
	if "%DKSCRIPT_PATH%" == "" dk_error "DKSCRIPT_PATH is invalid"; goto:eof
	
    echo .
    echo reloading %DKSCRIPT_PATH%
    start "" "%DKSCRIPT_PATH%"
    exit
goto:eof