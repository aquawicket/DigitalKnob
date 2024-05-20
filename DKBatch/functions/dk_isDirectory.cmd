@echo off
call DK

::####################################################################
::# dk_isDirectory(<path> <result>)
::#
::#
:dk_isDirectory () {
	call dk_debugFunc
	::if %__ARGC__% NEQ 2 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	if exist %~1\* (
		if not defined "%~2" goto:eof
		
		endlocal & set "%2=true"
		call dk_printVar "%2"
        (call )
		goto:eof
	)
	
    if not defined "%~2" goto:eof
	
	endlocal & set "%2=false"
	call dk_printVar "%2"
	(call)
goto:eof



:DKTEST ########################################################################

	call dk_isDirectory