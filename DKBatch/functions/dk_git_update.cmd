::dk_include_guard()

::################################################################################
::# dk_git_update(NO_CONFIRM)
::#
::#
:dk_git_update () {
	call:dk_verbose "dk_git_update(%*)"
	
    if "%1" NEQ "NO_CONFIRM" (
        echo Git Update? Any local changes will be lost.
        set /P CONFIRM="Are you sure? [Y] " 
    )
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    if NOT exist "%DKBRANCH_DIR%\.git" (
        "%GIT_EXE%" clone https://github.com/aquawicket/DigitalKnob.git "%DKBRANCH_DIR%"
    )
    call:dk_check_error

    cd "%DKBRANCH_DIR%"
    "%GIT_EXE%" pull --all
    "%GIT_EXE%" checkout -- .
    call:dk_check_error

    "%GIT_EXE%" checkout %DKBRANCH%
    if NOT "%ERRORLEVEL%" == "0" (
        echo Remote has no %DKBRANCH% branch. Creating...
        "%GIT_EXE%" checkout -b %DKBRANCH% main
        "%GIT_EXE%" push --set-upstream origin %DKBRANCH%
    )

    call:dk_check_error
goto:eof