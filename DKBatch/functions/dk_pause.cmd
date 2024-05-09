@echo off
call DK

::##################################################################################
::# dk_pause()
::#
::#    Pause execution and wait for <enter> keypress to continue
::#
:dk_pause () {
	call dk_debugFunc
	::if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	
	pause
goto:eof