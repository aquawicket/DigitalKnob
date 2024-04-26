::call dk_includeGuard

if [%ENABLE_dk_warning%]==[] set ENABLE_dk_warning=1
if [%TRACE_ON_WARNING%]==[] set TRACE_ON_WARNING=0
if [%PAUSE_ON_WARNING%]==[] set PAUSE_ON_WARNING=0
if [%HALT_ON_WARNING%]==[] set HALT_ON_WARNING=0
::TAG="  WARNING: "

::################################################################################
::# dk_warning(msg)
::#
::#	Print a warning message to the console
::#
::#	@msg	- The message to print
::#
:dk_warning () {
	::call dk_debugFunc
	
	if NOT [%ENABLE_dk_warning%] == [1] goto:eof
	set "msg=%*"
	
	:: if msg starts and ends with quotes, remove them
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	::### print variable ###
	::call set "value=%%%msg%%%"
    ::if "%value%" NEQ "" set "msg=%1 = '%value%'"
	::if "%value%" == "" set "msg=%1 = %red%NOT DEFINED%clr%"
	
	call dk_echo %yellow%%TAG%%msg%%clr%
	if [%TRACE_ON_WARNING%]==[1] call dk_stacktrace 		
	if [%HALT_ON_WARNING%]==[1] exit
	if [%PAUSE_ON_WARNING%]==[1] call dk_pause
	
goto:eof