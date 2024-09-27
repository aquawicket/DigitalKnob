@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::################################################################################
::# dk_gitCommit()
::#
::#
:dk_gitCommit
    call dk_debugFunc 0
 setlocal
 
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	cd %DKBRANCH_DIR%
 
	%dk_call% dk_gitDiffSummary
	::%dk_call% dk_gitStatus
    
    %dk_call% dk_echo
    %dk_call% dk_echo "Please enter some details about this commit, then press enter."
    %dk_call% dk_keyboardInput message
        
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
    %dk_call% dk_commandToVariable "%GIT_EXE%" "config --global credential.helper" STORE
    if not "%STORE%"=="store" (
        "%GIT_EXE%" config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
        
    %dk_call% dk_commandToVariable "%GIT_EXE%" "config --global user.email" USER_EMAIL
    if "%USER_EMAIL%"=="" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter an email address"
        %dk_call% dk_keyboardInput USER_EMAIL
        "%GIT_EXE%" config --global user.email !USER_EMAIL!
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.email !USER_EMAIL! saved"
        %dk_call% dk_echo
    )
        
    %dk_call% dk_commandToVariable "%GIT_EXE%" "config --global user.name" USER_NAME
    if "%USER_NAME%"=="" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter a username"
        %dk_call% dk_keyboardInput USER_NAME
        "%GIT_EXE%" config --global user.name "!USER_NAME!"
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.name !USER_NAME! saved"
        %dk_call% dk_echo
    )
        
    if "%message%"=="" set "message=git commit %date%"
        
    %dk_call% dk_echo
    %dk_call% dk_echo "git commit '%message%'"

    %dk_call% dk_confirm || %return%
    
    "%GIT_EXE%" commit -a -m "%message%"
    "%GIT_EXE%" push
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
    call dk_debugFunc 0
 setlocal
 
    %dk_call% dk_gitCommit
%endfunction%
