@echo off
call DK

::####################################################################
::# dk_makeDirectory(<path>)
::#
::#
:dk_makeDirectory () {
	call dk_debugFunc
	if %__ARGC__% NEQ 1 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	setlocal enableDelayedExpansion
	set "path=%~1"
	::set "path=%path:/=\%"
    if NOT exist "%path%" mkdir "%path%"
	endlocal
goto:eof