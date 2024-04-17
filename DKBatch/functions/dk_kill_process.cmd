::dk_include_guard()

::################################################################################
::# dk_kill_process(<name>)
::#
::#
:dk_kill_process () {
	call:dk_verbose "dk_kill_process(%*)"
	
    taskkill /IM "%1" /F > nul
goto:eof