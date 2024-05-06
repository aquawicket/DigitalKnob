@echo off
call DK

::####################################################################
::# dk_reset3rdparty()
::#
::#
:dk_reset3rdparty () {
	call dk_debugFunc
	
    echo Resetting 3rdParty Libraries . . .
        
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    cd %DK3RDPARTY_DIR%
    "%GIT_EXE%" clean -f -d
goto:eof