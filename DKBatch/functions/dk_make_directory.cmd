::dk_include_guard()

::####################################################################
::# dk_make_directory(<path>)
::#
::#
:dk_make_directory () {
	call dk_verbose "dk_make_directory(%*)"
	
    if NOT exist "%~1" mkdir "%~1"
goto:eof