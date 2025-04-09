@echo off
if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

::################################################################################
::# dk_gitCommit()
::#
::#
:dk_gitCommit
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% dk_gitDiffSummary
    
    %dk_call% dk_echo
    %dk_call% dk_echo "Please enter some details about this commit, then press enter."
    %dk_call% dk_keyboardInput commit_msg
        
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	
    %dk_call% dk_commandToVariable "%GIT_EXE%" -C %DKBRANCH_DIR% config --global credential.helper
	set "STORE=%dk_commandToVariable%"
    if not "%STORE%"=="store" (
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
        
    %dk_call% dk_commandToVariable "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.email
	set "USER_EMAIL=%dk_commandToVariable%"
    if "%USER_EMAIL%"=="" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter an email address"
        %dk_call% dk_keyboardInput USER_EMAIL
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.email !USER_EMAIL!
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.email !USER_EMAIL! saved"
        %dk_call% dk_echo
    )
        
    %dk_call% dk_commandToVariable "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.name
	set "USER_NAME=%dk_commandToVariable%"
    if "%USER_NAME%"=="" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter a username"
        %dk_call% dk_keyboardInput USER_NAME
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.name "!USER_NAME!"
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.name !USER_NAME! saved"
        %dk_call% dk_echo
    )
        
    if "%commit_msg%"=="" (set "commit_msg=git commit %date%")
        
    %dk_call% dk_echo
    %dk_call% dk_echo "git commit '%commit_msg%'"

    %dk_call% dk_confirm || (%return%)
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    "%GIT_EXE%" -C %DKBRANCH_DIR% commit -a -m "%commit_msg%"
    "%GIT_EXE%" -C %DKBRANCH_DIR% push
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitCommit
%endfunction%
