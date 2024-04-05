::dk_include_guard()

::##################################################################################
:: dk_debug(msg)
::
::	Print a debug message to the console
::
::	@msg	- The message to print
::
:dk_debug() {
	::call dk_verbose "%0(%*)"
	
	if %LOG_DEBUG% == 1 ( 
		echo %blue% DEBUG: %1 %clr%
	)
goto:eof