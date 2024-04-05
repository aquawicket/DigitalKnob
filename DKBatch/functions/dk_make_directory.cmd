::dk_include_guard()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_make_directory()
::
::
:dk_make_directory () {
	call dk_verbose "%0(%*)"

    if NOT exist "%~1" mkdir "%~1"
goto:eof