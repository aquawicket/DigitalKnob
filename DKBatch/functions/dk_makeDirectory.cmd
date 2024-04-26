call dk_includeGuard

::####################################################################
::# dk_makeDirectory(<path>)
::#
::#
:dk_makeDirectory () {
	call dk_debugFunc
	set "path=%~1"
	set "path=%path:/=\%"
    if NOT exist "%path%" mkdir "%path%"
goto:eof