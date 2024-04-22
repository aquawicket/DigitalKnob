::dk_include_guard()

::####################################################################
::# dk_getParentFolder(<input> <output>)
::#
::#
:dk_getParentFolder () {
	call dk_verbose "dk_getParentFolder(%*)"
	
    for %%a in ("%1") do for %%b in ("%%~dpa\.") do set "parent=%%~nxb"
    set "%2=%parent%"
goto:eof