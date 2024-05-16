@echo off
call DK

::##################################################################################
::# dk_pause()
::#
::#    Pause execution and wait for <enter> keypress to continue
::#
:dk_pause () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	pause
goto:eof