@rem shebang
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
rem # dk_gitCommit(repo_path)
rem #
rem #
:dk_gitCommit
	rem #  cache, wincred, store
	if NOT DEFINED git_credential_helper (set "git_credential_helper=store")  
%setlocal%

	rem ### repo_path
	if "%repo_path%" equ "" (set "repo_path=%~1")
	if "%repo_path%" equ "" (
		%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
		set "repo_path=!DKBRANCH_DIR!"
	)
	
	%dk_call% dk_gitDiffSummary
   
    %dk_call% dk_echo
    %dk_call% dk_echo "Please enter some details about this commit, then press enter."
    %dk_call% dk_keyboardInput commit_msg
       
    %dk_call% dk_validate git.exe %dk_call% dk_depend git
	
	rem ### set git init.defaultBranch
	set "dk_exec_NO_ERROR=1"
	%dk_call% dk_exec "%git.exe%" -C "%repo_path%" config --global init.defaultBranch
	set "defaultBranch=%dk_exec%"
    if "%defaultBranch%" neq "main" (
        %dk_call% git.exe -C "%repo_path%" config --global init.defaultBranch main
        echo "git init.defaultBranch is now set to main"
    )
	
	rem ### set git credential.helper
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%git.exe%" -C "%repo_path%" config --global credential.helper
	set "STORE=%dk_exec%"
    if "%STORE%" neq "%git_credential_helper%" (
        %dk_call% git.exe -C "%repo_path%" config --global credential.helper %git_credential_helper%
        echo "git credential.helper is now set to %git_credential_helper%"
    )
      
	rem ### set git user.email
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%git.exe%" -C "%repo_path%" config --global user.email
	set "USER_EMAIL=%dk_exec%"
    if "%USER_EMAIL%" equ "" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter an email address"
        %dk_call% dk_keyboardInput USER_EMAIL
        %dk_call% git.exe -C "%repo_path%" config --global user.email !USER_EMAIL!
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.email !USER_EMAIL! saved"
        %dk_call% dk_echo
    )
    
	rem ### set git user.name
	set "dk_exec_NO_ERROR=1"
    %dk_call% dk_exec "%git.exe%" -C "%repo_path%" config --global user.name
	set "USER_NAME=%dk_exec%"
    if "%USER_NAME%" equ "" (
        %dk_call% dk_echo
        %dk_call% dk_echo "please enter a username"
        %dk_call% dk_keyboardInput USER_NAME
        %dk_call% git.exe -C "%repo_path%" config --global user.name "!USER_NAME!"
        %dk_call% dk_echo
        %dk_call% dk_echo "git user.name !USER_NAME! saved"
        %dk_call% dk_echo
    )
       
    if "%commit_msg%" equ "" (set "commit_msg=git commit %date%")
    %dk_call% dk_echo
    %dk_call% dk_echo "commit message: '%commit_msg%'"
    %dk_call% dk_confirm || (%return%)
	
	rem ### Commit local repository
    %dk_call% git.exe -C "%repo_path%" commit -a -m "%commit_msg%"
	
	rem ### Backup the repository to  bundle file
	%dk_call% dk_validatePath DKStorage_Dir %dk_call% dk_DKStorage_Dir
	%dk_call% dk_gitBundle "%repo_path%" "%DKGit_gitbundle%" OVERWRITE
	rem %dk_call% dk_sftpUpload "%DKGit_gitbundle%" "%DKSftp_gitbundle%"
		
	rem ### Backup the HEAD to a tar.gz file
	rem %dk_call% git.exe -C "%repo_path%" archive --format=tar.gz -0 HEAD --output="%DKGit_targz%"
	rem rem %dk_call% dk_sftpUpload "%DKGit_targz%" "%DKSftp_git_targz%"
	
	rem ### Push the repository to the server
	rem set "repo_url=%DKSsh_git_url%"
	rem %dk_call% dk_urlExists "%repo_url%" && (
    
    set "DKUsb_git_url=D:/DigitalKnob/Development.git"
    %dk_call% git.exe config --global --add safe.directory %DKUsb_git_url%
    
		rem %dk_call% git.exe -C "%repo_path%" remote set-url origin %DKSsh_git_url%
		%dk_call% git.exe -C "%repo_path%" remote set-url origin %DKUsb_git_url%
		%dk_call% git.exe -C "%repo_path%" push
	rem ) || (
	rem	%dk_call% dk_error "repo_url:'%repo_url%' NOT FOUND"
	rem )
	
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_gitCommit
%endfunction%
