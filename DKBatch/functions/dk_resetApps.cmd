@echo off
call DK

::####################################################################
::# dk_resetApps()
::#
::#
:dk_resetApps () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    echo Resetting Apps . . .

    ::set /P CONFIRM="Are you sure? [Y] " 
    ::if /I "%CONFIRM%" neq "Y" goto:eof
	call dk_confirm || goto:eof
	
    cd %DKAPPS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof