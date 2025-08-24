@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::################################################################################
::# dk_gitCommit()
::#
::#
:dk_gitCommit
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% dk_gitDiffSummary
   
    %dk_call% dk_echo
    %dk_call% dk_echo "Please enter some details about this commit, then press enter."
    %dk_call% dk_keyboardInput commit_msg
       
    %dk_call% dk_validate GIT_EXE "%dk_call% dk_depend git"
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	
	::### set git init.defaultBranch
	set "dk_exec_NO_ERROR=1"
	%dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% config --global init.defaultBranch
	set "defaultBranch=%dk_exec%"
    if "%defaultBranch%" neq "main" (
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global init.defaultBranch main
        echo "git init.defaultBranch is now set to main"
    )
	
	::### set git credential.helper
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% config --global credential.helper
	set "STORE=%dk_exec%"
    if "%STORE%" neq "store" (
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
      
	::### set git user.email
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.email
	set "USER_EMAIL=%dk_exec%"
    if "%USER_EMAIL%" equ "" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter an email address"
        %dk_call% dk_keyboardInput USER_EMAIL
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.email !USER_EMAIL!
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.email !USER_EMAIL! saved"
        %dk_call% dk_echo
    )
    
	::### set git user.name
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.name
	set "USER_NAME=%dk_exec%"
    if "%USER_NAME%" equ "" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter a username"
        %dk_call% dk_keyboardInput USER_NAME
        "%GIT_EXE%" -C %DKBRANCH_DIR% config --global user.name "!USER_NAME!"
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.name !USER_NAME! saved"
        %dk_call% dk_echo
    )
       
    if "%commit_msg%" equ "" (set "commit_msg=git commit %date%")
    %dk_call% dk_echo
    %dk_call% dk_echo "commit message: '%commit_msg%'"
    %dk_call% dk_confirm || (%return%)
	
	::### Commit the local repository
    "%GIT_EXE%" -C %DKBRANCH_DIR% commit -a -m "%commit_msg%"
	
	
	if EXIST "%DKSTORAGE_DIR%" (
		::### Backup the local repository to a tar.gz file
		"%GIT_EXE%" -C "%DKBRANCH_DIR%" archive --format=tar.gz Development -0 -o "%DKSTORAGE_DIR%/DigitalKnob.tar.gz"
		
		::### Backup the local repository to a bundle file
		%dk_call% dk_gitBackup "%DKBRANCH_DIR%" "%DKSTORAGE_DIR%/DigitalKnob.git" OVERWRITE
	)
	
	
	
	::### Push to the remote repository
	set "REPO_URL=https://github.com/aquawicket/DigitalKnob.git"
	"%GIT_EXE%" -C "%DKBRANCH_DIR%" remote set-url origin %REPO_URL%
    "%GIT_EXE%" -C "%DKBRANCH_DIR%" push
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

    %dk_call% dk_gitCommit
%endfunction%
