call dk_includeGuard

::####################################################################
::# dk_resetPlugins()
::#
::#
:dk_resetPlugins () {
	call dk_debugFunc
	
    echo Resetting DKPlugins . . .

    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    cd %DKPLUGINS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof