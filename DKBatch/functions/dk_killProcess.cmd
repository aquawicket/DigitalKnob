::dk_includeGuard()

::################################################################################
::# dk_killProcess(<name>)
::#
::#
:dk_killProcess () {
	call dk_verbose "dk_killProcess(%*)"
	
    taskkill /IM "%1" /F > nul
goto:eof