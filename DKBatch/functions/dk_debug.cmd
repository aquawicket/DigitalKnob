::dk_includeGuard()
setlocal enableDelayedExpansion

if [%ENABLE_dk_debug%]==[] set ENABLE_dk_debug=1
if [%TRACE_ON_DEBUG%]==[] set TRACE_ON_DEBUG=0
if [%PAUSE_ON_DEBUG%]==[] set PAUSE_ON_DEBUG=0
if [%HALT_ON_DEBUG%]==[] set HALT_ON_DEBUG=0
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
	
	if NOT [%ENABLE_dk_debug%] == [1] goto:eof
	set "msg=%*"
	
	:: if msg starts and ends with quotes, remove them
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	::### print variable ###
	call set "value=%%%msg%%%"
    if "%value%" NEQ "" set "msg=%1 = '%value%'"
	if "%value%" == "" set "msg=%1 = %red%NOT DEFINED%clr%"
	
	::echo %blue%   DEBUG: !msg:~1,-1! %clr%
	call dk_echo %blue%%TAG%%msg%%clr%
	if [%TRACE_ON_DEBUG%]==[1] dk_stacktrace 		
	if [%HALT_ON_DEBUG%]==[1] exit
	if [%PAUSE_ON_DEBUG%]==[1] dk_pause
	
goto:eof