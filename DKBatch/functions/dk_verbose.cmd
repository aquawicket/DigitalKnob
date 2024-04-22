::dk_includeGuard()
setlocal enableDelayedExpansion

::################################################################################
::# dk_verbose(<message>)
::#
::#
:dk_verbose () {
	::echo dk_verbose(%*)
	
	set "msg=%*"
	
	:: if msg starts and ends with quotes, remove the first and last
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	if %LOG_VERBOSE% == 1 ( 
		echo %cyan% VERBOSE: !msg! %clr%
	)
	
endlocal
goto:eof