::dk_includeGuard()

::####################################################################
::# dk_checkError()
::#
::#
:dk_checkError () {
	call dk_debugFunc
	
    if %ERRORLEVEL% EQU 0 goto:eof
    call dk_error "ERRORLEVEL = %ERRORLEVEL%"
    pause
    exit
goto:eof