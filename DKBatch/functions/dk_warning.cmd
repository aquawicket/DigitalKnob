call dk_includeGuard

if "%ENABLE_dk_warning%"=="" set ENABLE_dk_warning=1
if "%TRACE_ON_WARNING%"==""  set TRACE_ON_WARNING=0
if "%PAUSE_ON_WARNING%"==""  set PAUSE_ON_WARNING=0
if "%HALT_ON_WARNING%"==""   set HALT_ON_WARNING=0
::WARNING_TAG="  WARNING: "
::################################################################################
::# dk_warning(msg)
::#
::#	Print a warning message to the console
::#
::#	@msg	- The message to print
::#
:dk_warning () {
	call dk_debugFunc
	
	if "%ENABLE_dk_warning%" NEQ "1" goto:eof
	setlocal enableDelayedExpansion	
		set "msg=%*"
		
		:: if msg starts and ends with quotes, remove them
		if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
		
		::call dk_toVariableInfo msg
		
		call dk_echo %yellow%%WARNING_TAG%%msg%%clr%
		if "%TRACE_ON_WARNING%"=="1" call dk_echo %yellow%*** TRACE_ON_WARNING ***%clr%  & call dk_stacktrace
		if "%HALT_ON_WARNING%"=="1"  call dk_echo %yellow%*** HALT_ON_WARNING ***%clr%   & call dk_exit
		if "%PAUSE_ON_WARNING%"=="1" call dk_echo %yellow%*** PAUSE_ON_WARNING ***%clr%  & call dk_pause
	endlocal
goto:eof