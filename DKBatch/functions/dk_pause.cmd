@echo off
::dk_includeGuard()

::##################################################################################
::# dk_pause(msg)
::#
::#    Pause execution and wait for keypress to continue
::#
:dk_pause () {
	::call dk_verbose "dk_pause(%*)"
	::[ %1 ] && dk_error "Incorrect number of parameters"
	
	pause
goto:eof