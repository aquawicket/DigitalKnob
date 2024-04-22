::dk_include_guard()

::####################################################################
::# dk_checkError()
::#
::#
:dk_checkError () {
	call dk_verbose "dk_checkError(%*)"
	
    if %ERRORLEVEL% EQU 0 goto:eof
    call dk_error "ERRORLEVEL = %ERRORLEVEL%"
    pause
    exit
goto:eof