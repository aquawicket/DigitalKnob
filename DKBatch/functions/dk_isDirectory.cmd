@echo off
call DK

::####################################################################
::# dk_isDirectory(path rtn_var)
::#
::#
:dk_isDirectory () {
	call dk_debugFunc
	if %__ARGC__% lss 1 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	if exist %~1\* (
		if defined "%~2" (endlocal & call dk_set %2 true)
        (call )
		goto:eof
	)
	
    if defined "%~2" (endlocal & call dk_set %2 false)
	(call)
goto:eof



:DKTEST ########################################################################

	call dk_isDirectory "C:\Windows" && call dk_info "is a directory" || call dk_info "is NOT a directory"
	
	call dk_isDirectory "C:\NotADir" && call dk_info "is a directory" || call dk_info "is NOT a directory"