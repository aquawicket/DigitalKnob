::call dk_includeGuard

::#####################################################################
::# dk_getParentDir(<input> <output>)
::#
::#
:dk_getParentDir () {
	call dk_debugFunc
	
	for %%A in (%1.) do set "parent=%%~dpA"
    set "%2=%parent%"
goto:eof