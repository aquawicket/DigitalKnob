::include_guard()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_verbose()
::
::
:dk_verbose() {
	::call dk_verbose "%0(%*)"
	
	if %LOG_VERBOSE% == 1 ( 
		echo %cyan% VERBOSE: %1 %clr%
	)
goto:eof