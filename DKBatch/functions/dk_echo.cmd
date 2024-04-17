::include_guard()

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_echo(msg)
::
::
:dk_echo () {
	::call dk_verbose "%0(%*)"
	
	echo %*
goto:eof