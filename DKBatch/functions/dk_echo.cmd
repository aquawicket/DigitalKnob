::include_guard()


:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_echo(msg)
::
::
:dk_echo () {
	::call dk_debugFunc
	
	echo %*
goto:eof