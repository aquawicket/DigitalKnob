::dk_include_guard()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_get_filename()
::
::
:dk_get_filename () {
	call dk_verbose "dk_get_filename(%*)"
	
    if [%1] == [] (
        echo "ERROR: dk_get_filename() parameter 1 is invalid"
        goto:eof
    )
    if [%2] == [] (
        echo "ERROR: dk_get_filename() parameter 2 is invalid"
        goto:eof
    )
    
    for %%F in ("%1") do (
        set %2=%%~nxF
        set val=%%~nxF
    )
    
    ::echo dk_get_filename(%*) -^> %2 = %val%
    ::call dk_check_error
goto:eof