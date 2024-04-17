::dk_include_guard()

::####################################################################
::# dk_reload()
::#
::#
:dk_reload () {
	call:dk_verbose "dk_reload(%*)"
	
    echo .
    echo reloading %SCRIPT_NAME%
    start "" "%SCRIPT_DIR%\%SCRIPT_NAME%"
    exit
goto:eof