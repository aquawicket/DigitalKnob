call dk_includeGuard

::################################################################################
::# dk_gitUpdate(NO_CONFIRM)
::#
::#
:dk_gitUpdate () {
	call dk_debugFunc
	
    if "%1" NEQ "NO_CONFIRM" (
        echo Git Update? Any local changes will be lost.
        set /P CONFIRM="Are you sure? [Y] " 
    )
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    if NOT exist "%DKBRANCH_DIR%\.git" (
        "%GIT_EXE%" clone https://github.com/aquawicket/DigitalKnob.git "%DKBRANCH_DIR%"
    )
    call dk_checkError

    cd "%DKBRANCH_DIR%"
    "%GIT_EXE%" pull --all
    "%GIT_EXE%" checkout -- .
    call dk_checkError

    "%GIT_EXE%" checkout %DKBRANCH%
    if NOT "%ERRORLEVEL%" == "0" (
        echo Remote has no %DKBRANCH% branch. Creating...
        "%GIT_EXE%" checkout -b %DKBRANCH% main
        "%GIT_EXE%" push --set-upstream origin %DKBRANCH%
    )

    call dk_checkError
goto:eof