::dk_include_guard()

::####################################################################
::# dk_get_parent_folder(<input> <output>)
::#
::#
:dk_get_parent_folder () {
	call:dk_verbose "dk_get_parent_folder(%*)"
	
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
goto:eof