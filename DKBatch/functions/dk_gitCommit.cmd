@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %0

::################################################################################
::# dk_gitCommit()
::#
::#
:dk_gitCommit
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitDiffSummary
	::%dk_call% dk_gitStatus
    
    %dk_call% dk_echo
    %dk_call% dk_echo "Please enter some details about this commit, then press enter."
    %dk_call% dk_keyboardInput message
        
    %dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_validateBranch"
    cd %DKBRANCH_DIR%
    
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    %dk_call% dk_commandToVariable "%GIT_EXE%" "config --global credential.helper" STORE
    if not "%STORE%"=="store" (
        "%GIT_EXE%" config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
        
    %dk_call% dk_commandToVariable "%GIT_EXE%" "config --global user.email" USER_EMAIL
    if "%USER_EMAIL%"=="" (
        %dk_call% dk_echo
        echo please enter an email address
        %dk_call% dk_keyboardInput input
        "%GIT_EXE%" config --global user.email "%input%"
        %dk_call% dk_echo
        echo "git user.email %input% saved"
        %dk_call% dk_echo
    )
        
    %dk_call% dk_commandToVariable "%GIT_EXE%" "config --global user.email" USER_NAME
    if "%USER_NAME%"=="" (
        %dk_call% dk_echo
        echo please enter a username
        %dk_call% dk_keyboardInput input
        "%GIT_EXE%" config --global user.name "%input%"
        %dk_call% dk_echo
        echo "git user.name %input% saved"
        %dk_call% dk_echo
    )
        
    if "%message%"=="" set "message=git commit"
        
    %dk_call% dk_echo
    echo git commit "%message%"

    %dk_call% dk_confirm || goto:eof
    
    "%GIT_EXE%" commit -a -m "%message%"
    "%GIT_EXE%" push
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitCommit
%endfunction%
