::dk_include_guard()

::####################################################################
::# dk_reset_3rdparty()
::#
::#
:dk_reset_3rdparty () {
	call:dk_verbose "dk_reset_3rdparty(%*)"
	
    echo Resetting 3rdParty Libraries . . .
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    cd %DK3RDPARTY_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof