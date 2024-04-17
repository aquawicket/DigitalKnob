::dk_include_guard()
setlocal enableDelayedExpansion

::################################################################################
::# dk_verbose(<message>)
::#
::#
:dk_verbose () {
	::echo %0(%*)
	
	set "msg=%*"
	
	:: if msg stats and ends with ", remove the first and last
	if "" == %msg:~0,1%%msg:~-1% set "msg=!msg:~1,-1!"
	
	if %LOG_VERBOSE% == 1 ( 
		echo %cyan% VERBOSE: !msg! %clr%
	)
	
endlocal
goto:eof