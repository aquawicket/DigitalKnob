@echo off
call DK

::####################################################################
::# dk_resetPlugins()
::#
::#
:dk_resetPlugins () {
	call dk_debugFunc
	if %__ARGC__% NEQ 0 (dk_error "%__FUNCTION__%(): incorrect number of arguments")
	
    echo Resetting DKPlugins . . .

    call dk_confirm || goto:eof
    
    cd %DKPLUGINS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof