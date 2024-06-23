@echo off
call DK.cmd

::##################################################################################
::# dk_pause()
::#
::#    Pause execution and wait for <enter> keypress to continue
::#
:dk_pause () {
	call dk_debugFunc
	if %__ARGC__% neq 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	pause
goto:eof




:DKTEST #####################################################################
	
	call dk_pause