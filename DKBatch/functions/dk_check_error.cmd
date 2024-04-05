::dk_include_guard()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_check_error()
::
::
:dk_check_error () {
	call dk_verbose "dk_check_error(%*)"

    if %ERRORLEVEL% EQU 0 goto:eof
    call dk_error "ERRORLEVEL = %ERRORLEVEL%"
    pause
    exit
goto:eof