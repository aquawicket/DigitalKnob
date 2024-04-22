::dk_include_guard()

::####################################################################
::# dk_makeDirectory(<path>)
::#
::#
:dk_makeDirectory () {
	call dk_verbose "dk_makeDirectory(%*)"
	
    if NOT exist "%~1" mkdir "%~1"
goto:eof