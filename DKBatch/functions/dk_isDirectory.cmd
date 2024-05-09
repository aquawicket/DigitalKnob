@echo off
call DK

::####################################################################
::# dk_isDirectory(<path> <result>)
::#
::#
:dk_isDirectory () {
	call dk_debugFunc
	if "%~1" equ "" call dk_error "%__FUNCTION__%(%*): argument 1 is invalid"
	
	if exist %~1\* (
		if "%~2" neq "" endlocal & set "%2=true"
        (call )
		goto:eof
	)
	
    if "%~2" neq "" endlocal & set "%2=false"
	(call)
goto:eof