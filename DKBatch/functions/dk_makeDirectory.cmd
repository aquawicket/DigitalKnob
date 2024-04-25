::dk_includeGuard()

::####################################################################
::# dk_makeDirectory(<path>)
::#
::#
:dk_makeDirectory () {
	call dk_debugFunc
	
    if NOT exist "%~1" mkdir "%~1"
goto:eof