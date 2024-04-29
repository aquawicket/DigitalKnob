@echo off
call dk_includeGuard
call DK

::####################################################################
::# dk_makeDirectory(<path>)
::#
::#
:dk_makeDirectory () {
	call dk_debugFunc
	setlocal enableDelayedExpansion
	set "path=%~1"
	::set "path=%path:/=\%"
    if NOT exist "%path%" mkdir "%path%"
	endlocal
goto:eof