::include_guard()

:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_message(msg)
::
::
:dk_message () {
	::call dk_verbose "%0(%*)"
	
	echo %1
goto:eof