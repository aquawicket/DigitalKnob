::dk_includeGuard()
setlocal enableDelayedExpansion

if [%ENABLE_dk_info%]==[] set ENABLE_dk_info=1
if [%TRACE_ON_INFO%]==[] set TRACE_ON_INFO=0
if [%PAUSE_ON_INFO%]==[] set PAUSE_ON_INFO=0
if [%HALT_ON_INFO%]==[] set HALT_ON_INFO=0
::TAG="  INFO: "
::################################################################################
::# dk_info(<message>)
::#
::#	    Print a info message to the console
::#
::#     @msg	- The message to print
::#
:dk_info () {
	::echo dk_info(%*)
	
	if NOT [%ENABLE_dk_info%] == [1] goto:eof
	set "msg=%1"
	::call dk_toVariableInfo msg
	
	:: if msg starts and ends with quotes, remove the first and last
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	::### dk_toVariableInfo ###
	::call set "value=%%%msg%%%"
    ::if "%value%" NEQ "" set "msg=%1 = '%value%'"
	::if "%value%" == "" set "msg=%1 = %red%NOT DEFINED%clr%"
	
	call dk_echo %cyan%%TAG%%msg%%clr%
	if [%TRACE_ON_INFO%]==[1] call dk_stacktrace 		
	if [%HALT_ON_INFO%]==[1] exit
	if [%PAUSE_ON_INFO%]==[1] call dk_pause
	
endlocal
goto:eof