::dk_include_guard()

::####################################################################
::# dk_reset_plugins()
::#
::#
:dk_reset_plugins () {
	call:dk_verbose "dk_reset_plugins(%*)"
	
    echo Resetting DKPlugins . . .

    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    cd %DKPLUGINS_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof