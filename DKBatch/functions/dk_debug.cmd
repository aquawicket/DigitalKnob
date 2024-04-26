call dk_includeGuard

if [%ENABLE_dk_debug%]==[] set ENABLE_dk_debug=1
if [%TRACE_ON_DEBUG%]==[] set TRACE_ON_DEBUG=0
if [%PAUSE_ON_DEBUG%]==[] set PAUSE_ON_DEBUG=0
if [%HALT_ON_DEBUG%]==[] set HALT_ON_DEBUG=0
::TAG="  VERBOSE: "

setlocal enableDelayedExpansion
::##################################################################################
::# dk_debug(msg)
::#
::#   Print a debug message to the console
::#
::#   @msg	- The message to print
::#
:dk_debug () {
	::call dk_debugFunc
	
	if NOT [%ENABLE_dk_debug%] == [1] goto:eof
	set "msg=%*"
	
	:: if msg starts and ends with quotes, remove them
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	::### print variable ###
	call set "value=%%%msg%%%"
    if "%value%" NEQ "" set "msg=%1 = '%value%'"
	if "%value%" == "" set "msg=%1 = %red%NOT DEFINED%clr%"
	
	call dk_echo %blue%%TAG%%msg%%clr%
	if [%TRACE_ON_DEBUG%]==[1] call dk_stacktrace 		
	if [%HALT_ON_DEBUG%]==[1] exit
	if [%PAUSE_ON_DEBUG%]==[1] call dk_pause
	
	endlocal
goto:eof