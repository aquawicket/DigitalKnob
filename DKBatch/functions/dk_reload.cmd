@echo off
call DK

::####################################################################
::# dk_reload()
::#
::#
:dk_reload () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
	if "%DKSCRIPT_PATH%" == "" dk_error "DKSCRIPT_PATH is invalid"; goto:eof
	
    echo .
    echo reloading %DKSCRIPT_PATH%
    start "" "%DKSCRIPT_PATH%" & exit & exit & exit
goto:eof