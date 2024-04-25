::dk_includeGuard()

::################################################################################
::# dk_warning(msg)
::#
::#	Print a warning message to the console
::#
::#	@msg	- The message to print
::#
:dk_warning () {
	::call dk_debugFunc
	
	echo %yellow% WARNING: %1 %clr%
goto:eof