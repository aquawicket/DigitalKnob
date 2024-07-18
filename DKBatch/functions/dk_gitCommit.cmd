@echo off
call %DKBATCH_FUNCTIONS_DIR_%DK.cmd

::################################################################################
::# dk_gitCommit()
::#
::#
:dk_gitCommit
	call dk_debugFunc
	if %__ARGC__% neq 0 call dk_error "%__FUNCTION__%:%__ARGV__% incorrect number of arguments"
	
	call dk_gitDiffSummary
	
    echo "Please enter some details about this commit, then press enter."
    set /p message=">" 
        
	call dk_validate DKBRANCH_DIR "call dk_validateBranch"
    cd %DKBRANCH_DIR%
    
	call dk_validate GIT_EXE "call dk_installGit"
    call dk_commandToVariable "%GIT_EXE% config --global credential.helper" STORE
    if not "%STORE%"=="store" (
        "%GIT_EXE%" config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
        
    call dk_commandToVariable "%GIT_EXE% config --global user.email" USER_EMAIL
    if "%USER_EMAIL%"=="" (
        call dk_echo
        echo please enter an email address
        set /p input=">" 
        "%GIT_EXE%" config --global user.email "%input%"
        call dk_echo
        echo "git user.email %input% saved"
        call dk_echo
    )
        
    call dk_commandToVariable "%GIT_EXE% config --global user.email" USER_NAME
    if "%USER_NAME%"=="" (
        call dk_echo
        echo please enter a username
        set /p input=">" 
        "%GIT_EXE%" config --global user.name "%input%"
        call dk_echo
        echo "git user.name %input% saved"
        call dk_echo
    )
        
    if "%message%"=="" set "message=git commit"
        
    call dk_echo
    echo git commit "%message%"

    call dk_confirm || goto:eof
    
    "%GIT_EXE%" commit -a -m "%message%"
    "%GIT_EXE%" push

goto:eof




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	call dk_debugFunc
	
	call dk_gitCommit
goto:eof
