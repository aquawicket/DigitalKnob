@echo off
call DK

::####################################################################
::# dk_isDirectory(<path> <result>)
::#
::#
:dk_isDirectory () {
	call dk_debugFunc
	::if %__ARGC__% NEQ 2 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
	if exist %~1\* (
		if "%~2" neq "" endlocal & set "%2=true"
        (call )
		goto:eof
	)
	
    if "%~2" neq "" endlocal & set "%2=false"
	(call)
goto:eof