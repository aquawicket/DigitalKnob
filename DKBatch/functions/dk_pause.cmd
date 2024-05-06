@echo off
call DK

::##################################################################################
::# dk_pause(msg)
::#
::#    Pause execution and wait for keypress to continue
::#
:dk_pause () {
	call dk_debugFunc
	::[ %1 ] && dk_error "Incorrect number of parameters"
	
	pause
goto:eof