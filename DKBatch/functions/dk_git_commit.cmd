::dk_include_guard()

::################################################################################
::# dk_git_commit()
::#
::#
:dk_git_commit () {
	call:dk_verbose "dk_git_commit(%*)"
	
    echo "Please enter some details about this commit, then press enter."
    set /p message=">" 
        
    cd %DKBRANCH_DIR%
        
    call:dk_command_to_variable "%GIT_EXE%" config --global credential.helper STORE
    if not "%STORE%"=="store" (
        "%GIT_EXE%" config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
        
    call:dk_command_to_variable "%GIT_EXE%" config --global user.email USER_EMAIL
    if "%USER_EMAIL%"=="" (
        echo.
        echo please enter an email address
        set /p input=">" 
        "%GIT_EXE%" config --global user.email "%input%"
        echo.
        echo "git user.email %input% saved"
        echo.
    )
        
    call:dk_command_to_variable "%GIT_EXE%" config --global user.email USER_NAME
    if "%USER_NAME%"=="" (
        echo.
        echo please enter a username
        set /p input=">" 
        "%GIT_EXE%" config --global user.name "%input%"
        echo.
        echo "git user.name %input% saved"
        echo.
    )
        
    if "%message%"=="" set "message=git commit"
        
    echo.
    echo git commit "%message%"
    set /P CONFIRM="Are you sure? [Y] " 
    if /I "%CONFIRM%" NEQ "Y" goto:eof
        
    "%GIT_EXE%" commit -a -m "%message%"
    "%GIT_EXE%" push
        
    call:dk_check_error
goto:eof