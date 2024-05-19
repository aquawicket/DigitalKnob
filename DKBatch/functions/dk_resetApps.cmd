@echo off
call DK

::####################################################################
::# dk_resetApps()
::#
::#
:dk_resetApps () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (call dk_error "%__FUNCTION__%(%__ARGC__%): incorrect number of arguments")
	
    echo Resetting Apps . . .

	call dk_confirm || goto:eof
	
    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof