::dk_include_guard()

::#################################################################################
::# dk_error(msg)
::#
::#	Print a error message to the console
::#
::#	@msg	- The message to print
::#
:dk_error () {
	::call dk_verbose "dk_error(%*)"
	
	echo %red%   ERROR: %1 %clr%
	::dk_stacktrace
	::if [ $HALT_ON_ERRORS == 1 ]; then
	::	exit 1
	::fi
goto:eof