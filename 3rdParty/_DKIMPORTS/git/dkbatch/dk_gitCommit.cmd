rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ################################################################################
rem # dk_gitCommit()
rem #
rem #
:dk_gitCommit
%setlocal%

	%dk_call% dk_gitDiffSummary
   
    %dk_call% dk_echo
    %dk_call% dk_echo "Please enter some details about this commit, then press enter."
    %dk_call% dk_keyboardInput commit_msg
       
rem %dk_call% dk_validate git.exe %dk_call% dk_depend git
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	
	rem ### set git init.defaultBranch
	set "dk_exec_NO_ERROR=1"
	%dk_call% dk_exec "%git.exe%" -C %DKBRANCH_DIR% config --global init.defaultBranch
	set "defaultBranch=%dk_exec%"
    if "%defaultBranch%" neq "main" (
        %dk_call% git.exe -C %DKBRANCH_DIR% config --global init.defaultBranch main
        echo "git init.defaultBranch is now set to main"
    )
	
	rem ### set git credential.helper
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%git.exe%" -C %DKBRANCH_DIR% config --global credential.helper
	set "STORE=%dk_exec%"
    if "%STORE%" neq "store" (
        %dk_call% git.exe -C %DKBRANCH_DIR% config --global credential.helper store
        echo "git credential.helper is now set to store"
    )
      
	rem ### set git user.email
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%git.exe%" -C %DKBRANCH_DIR% config --global user.email
	set "USER_EMAIL=%dk_exec%"
    if "%USER_EMAIL%" equ "" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter an email address"
        %dk_call% dk_keyboardInput USER_EMAIL
        %dk_call% git.exe -C %DKBRANCH_DIR% config --global user.email !USER_EMAIL!
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.email !USER_EMAIL! saved"
        %dk_call% dk_echo
    )
    
	rem ### set git user.name
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%git.exe%" -C %DKBRANCH_DIR% config --global user.name
	set "USER_NAME=%dk_exec%"
    if "%USER_NAME%" equ "" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter a username"
        %dk_call% dk_keyboardInput USER_NAME
        %dk_call% git.exe -C %DKBRANCH_DIR% config --global user.name "!USER_NAME!"
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.name !USER_NAME! saved"
        %dk_call% dk_echo
    )
       
    if "%commit_msg%" equ "" (set "commit_msg=git commit %date%")
    %dk_call% dk_echo
    %dk_call% dk_echo "commit message: '%commit_msg%'"
    %dk_call% dk_confirm || (%return%)
	
	rem ### Commit the local repository
    %dk_call% git.exe -C %DKBRANCH_DIR% commit -a -m "%commit_msg%"
	
	%dk_call% dk_validate DKStorage_Dir %dk_call% dk_DKStorage_Dir
	if EXIST "%DKStorage_Dir%" (
		rem ### Backup the local repository to a bundle file
		%dk_call% dk_gitBundle "%DKBRANCH_DIR%" "%DKStorage_Dir%/DigitalKnob.bundle" OVERWRITE
		%dk_call% dk_sftpUpload "%DKStorage_Dir%/DigitalKnob.bundle" "/DigitalKnob/DKStorage/DigitalKnob.bundle"
		
		rem ### Backup the local repository to a tar.gz file
		%dk_call% git.exe -C "%DKBRANCH_DIR%" archive --format=tar.gz Development -0 -o "%DKStorage_Dir%/DigitalKnob.tar.gz"
		rem %dk_call% dk_sftpUpload "%DKStorage_Dir%/DigitalKnob.tar.gz" "/DigitalKnob/DKStorage/DigitalKnob.tar.gz"
	)
	
	
rem 	rem ### Push to the remote repository
rem 	set "REPO_URL=https://github.com/aquawicket/DigitalKnob.git"
rem 	%dk_call% dk_urlExists "%REPO_URL%" && (
rem 		%dk_call% git.exe -C "%DKBRANCH_DIR%" remote set-url origin %REPO_URL%
rem 		%dk_call% git.exe -C "%DKBRANCH_DIR%" push
rem 	) || (
rem 		%dk_call% dk_error "REPO_URL:'%REPO_URL%' NOT FOUND"
rem 	)	
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_gitCommit
%endfunction%
