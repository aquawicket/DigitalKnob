<<<<<<< HEAD
@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*
=======
@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################

>>>>>>> Development

::################################################################################
::# dk_gitCommit()
::#
::#
:dk_gitCommit
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
	%dk_call% dk_gitDiffSummary
    
    %dk_call% dk_echo
    %dk_call% dk_echo "Please enter some details about this commit, then press enter."
    %dk_call% dk_keyboardInput commit_msg
        
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_installGit"
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	
<<<<<<< HEAD
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% config --global credential.helper" STORE
    if not "%STORE%"=="store" (
=======
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% config --global credential.helper
	set "STORE=%dk_exec%"
    if not "%STORE%" equ "store" (
>>>>>>> Development
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
        
<<<<<<< HEAD
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% config --global user.email" USER_EMAIL
    if "%USER_EMAIL%"=="" (
=======
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.email
	set "USER_EMAIL=%dk_exec%"
    if "%USER_EMAIL%" equ "" (
>>>>>>> Development
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter an email address"
        %dk_call% dk_keyboardInput USER_EMAIL
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.email !USER_EMAIL!
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.email !USER_EMAIL! saved"
        %dk_call% dk_echo
    )
        
<<<<<<< HEAD
    %dk_call% dk_commandToVariable "%GIT_EXE%" "-C %DKBRANCH_DIR% config --global user.name" USER_NAME
    if "%USER_NAME%"=="" (
=======
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.name
	set "USER_NAME=%dk_exec%"
    if "%USER_NAME%" equ "" (
>>>>>>> Development
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter a username"
        %dk_call% dk_keyboardInput USER_NAME
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.name "!USER_NAME!"
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.name !USER_NAME! saved"
        %dk_call% dk_echo
    )
        
<<<<<<< HEAD
    if "%commit_msg%"=="" set "commit_msg=git commit %date%"
=======
    if "%commit_msg%" equ "" (set "commit_msg=git commit %date%")
>>>>>>> Development
        
    %dk_call% dk_echo
    %dk_call% dk_echo "git commit '%commit_msg%'"

<<<<<<< HEAD
    %dk_call% dk_confirm || %return%
    
    "%GIT_EXE%" commit -a -m "%commit_msg%"
    "%GIT_EXE%" push
=======
    %dk_call% dk_confirm || (%return%)
    
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
    "%GIT_EXE%" -C %DKBRANCH_DIR% commit -a -m "%commit_msg%"
    "%GIT_EXE%" -C %DKBRANCH_DIR% push
>>>>>>> Development
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
<<<<<<< HEAD
    call dk_debugFunc 0
 setlocal
 
=======
setlocal
	%dk_call% dk_debugFunc 0

>>>>>>> Development
    %dk_call% dk_gitCommit
%endfunction%
