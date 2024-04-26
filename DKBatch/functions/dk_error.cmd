call dk_includeGuard

if [%ENABLE_dk_error%]==[] set ENABLE_dk_error=1
if [%TRACE_ON_ERROR%]==[] set TRACE_ON_ERROR=1
if [%PAUSE_ON_ERROR%]==[] set PAUSE_ON_ERROR=1
if [%HALT_ON_ERROR%]==[] set HALT_ON_ERROR=0
:: ERROR_TAG="ERROR: "
::################################################################################
::# dk_error(<message>)
::#
::#	Print a error message to the console
::#
::#	@msg	- The message to print
::#
:dk_error () {
	setlocal enableDelayedExpansion
	call dk_debugFunc
	::echo _callerpath = %_callerpath%
	
	if NOT [%ENABLE_dk_error%] == [1] goto:eof
	set "msg=%1"
	::call dk_toVariableInfo msg
	
	:: if msg starts and ends with quotes, remove the first and last
	::if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	
	::### dk_toVariableInfo ###
	::call set "value=%%%msg%%%"
    ::if "%value%" NEQ "" set "msg=%1 = '%value%'"
	::if "%value%" == "" set "msg=%1 = %red%NOT DEFINED%clr%"
	
	::call dk_echo %red%%ERROR_TAG%%bg_red%%msg%%clr%%red%
	call echo.
	call dk_echo %red%%msg%%clr%
	if [%TRACE_ON_ERROR%]==[1] call dk_printError ERROR %_callerpath% %msg%
	::if [%TRACE_ON_ERROR%]==[1] call dk_stacktrace
	if [%HALT_ON_ERROR%]==[1] call dk_echo ${red}*** HALT_ON_ERROR ***${clr} && exit
	if [%PAUSE_ON_ERROR%]==[1] call dk_pause
	
endlocal
goto:eof