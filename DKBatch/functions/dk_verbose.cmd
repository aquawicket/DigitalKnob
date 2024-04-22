::dk_includeGuard()
setlocal enableDelayedExpansion

if [%ENABLE_dk_verbose%]==[] set ENABLE_dk_verbose=1
if [%TRACE_ON_VERBOSE%]==[] set TRACE_ON_VERBOSE=0
if [%PAUSE_ON_VERBOSE%]==[] set PAUSE_ON_VERBOSE=0
if [%HALT_ON_VERBOSE%]==[] set HALT_ON_VERBOSE=0
::TAG="  VERBOSE: "
::################################################################################
::# dk_verbose(<message>)
::#
::#	    Print a verbose message to the console
::#
::#     @msg	- The message to print
::#
:dk_verbose () {
	::echo dk_verbose(%*)
	
	if NOT [%ENABLE_dk_verbose%] == [1] goto:eof
	set "msg=%1"
	::call dk_toVariableInfo msg
	
	:: if msg starts and ends with quotes, remove the first and last
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	::### dk_toVariableInfo ###
	::call set "value=%%%msg%%%"
    ::if "%value%" NEQ "" set "msg=%1 = '%value%'"
	::if "%value%" == "" set "msg=%1 = %red%NOT DEFINED%clr%"
	
	call dk_echo %cyan%%TAG%%msg%%clr%
	if [%TRACE_ON_VERBOSE%]==[1] call dk_stacktrace 		
	if [%HALT_ON_VERBOSE%]==[1] exit
	if [%PAUSE_ON_VERBOSE%]==[1] call dk_pause
	
endlocal
goto:eof