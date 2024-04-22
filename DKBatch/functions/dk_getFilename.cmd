::dk_includeGuard()

::################################################################################
::# dk_getFilename(<path> <output_variable>)
::#
::#
:dk_getFilename () {
	call dk_verbose "dk_getFilename(%*)"
	
    if [%1] == [] (
        echo "ERROR: dk_getFilename() parameter 1 is invalid"
        goto:eof
    )
    if [%2] == [] (
        echo "ERROR: dk_getFilename() parameter 2 is invalid"
        goto:eof
    )
    
    for %%F in ("%1") do (
        set %2=%%~nxF
        set val=%%~nxF
    )
    
    ::echo dk_getFilename(%*) -^> %2 = %val%
    call dk_checkError
goto:eof