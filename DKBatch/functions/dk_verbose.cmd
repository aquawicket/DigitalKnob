::include_guard()

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: dk_verbose()
::
::
:dk_verbose() {
	::echo "dk_verbose(%*)"
::	if %LOG_VERBOSE% == 1 ( 
		echo %blue% VERBOSE: %1 %clr%
::	)
goto:eof