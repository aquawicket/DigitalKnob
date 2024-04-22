::dk_includeGuard()
setlocal enableDelayedExpansion

::##################################################################################
::# dk_debug(msg)
::#
::#   Print a debug message to the console
::#
::#   @msg	- The message to print
::#
:dk_debug () {
	::call dk_verbose "dk_debug(%*)"
	
::	[ $# -lt 1 ] && dk_error "dk_debug($*): requires at least 1 parameter"
	
	if NOT %LOG_DEBUG% == 1 goto:eof
	
	set "msg=%*"
	
	:: if msg starts and ends with quotes, remove the first and last
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	::### print variable ###
	call set "value=%%%msg%%%"
    if "%value%" NEQ "" set "msg=%1 = '%value%'"
	if "%value%" == "" set "msg=%1 = %red%NOT DEFINED%clr%"
	
	::echo %blue%   DEBUG: !msg:~1,-1! %clr%
	echo %blue%   DEBUG: !msg! %clr%
goto:eof