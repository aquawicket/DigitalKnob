::dk_include_guard()

::#####################################################################
::# dk_get_parent_dir(<input> <output>)
::#
::#
:dk_get_parent_dir () {
	call:dk_verbose "dk_get_parent_dir(%*)"
	
	for %%A in (%1.) do set "parent=%%~dpA"
    set "%2=%parent%"
goto:eof