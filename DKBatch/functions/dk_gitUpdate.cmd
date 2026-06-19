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
rem # dk_gitUpdate(repo_url, repo_path)
rem #
rem #
:dk_gitUpdate
  set "dk_gitUpdate_BACKUP=1"
%setlocal%
  if "%1" == "continue" goto :continue
	
	set "repo_url=D:/DigitalKnob/Development.git"
	rem ### repo_url
	if "%repo_url%" equ "" (set "repo_url=%~1")
	if "%repo_url%" equ "" (set "repo_url=%DKHttp_git_url%")
	if "%repo_url%" equ "" (set "repo_url=http://aquawicket.com/DigitalKnob/Development.git")
	
	rem ### repo_path
	if "%repo_path%" equ "" (set "repo_path=%~2")
	if "%repo_path%" equ "" (
		%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
		set "repo_path=!DKBRANCH_DIR!"
	)
	
	rem ### repo_branch
	set "repo_branch=%DKBranch%"
	
	
	rem if NOT defined DKStorage_Dir (set "DKStorage_Dir=%DIGITALKNOB_DIR%/DKStorage")
	rem %dk_call% dk_download "%DKHttp_gitbundle%" "%DKGit_gitbundle%" OVERWRITE
   
    rem if "%3" neq "NO_CONFIRM" (
    rem    echo Git Update? Any local changes will be lost.
    rem    %dk_call% dk_confirm || %return%
    rem )

    %dk_call% dk_validate git.exe %dk_call% dk_depend git
   
    if NOT EXIST "%repo_path%/.git" (
		if EXIST "%repo_path%" (
			rem ###### Backup Branch directory and clone ######
rem			if "%dk_gitUpdate_BACKUP%" equ "1" (
rem				%dk_call% dk_copy "%repo_path%" "%repo_path%_BACKUP" OVERWRITE
rem			)
			set "delete_repo=1"
		)
		rem ####################################################################
		set "clone_repo=1"	
	)
	
	rem #######################################################################################################################	
	rem NOTE: 	This must clone and update within the parentheses. rd /s /q "%repo_path%" removes the current DigitalKnob
	rem			folder, leaving the current running batch process abandoned until it's cloned again. It seems like when we are
	rem 		in the scope of called batch files, we loose all references to those deleted file once we leave the parentheses.
	rem         This includes variables, functions, etc. So to fix this, after we delete the very files our context is running
	rem			from, we must stay in parentheses until those files are restored and updated, or we will lose the context.
	rem  Another method is to recall the script and jump to a :continue label at it's new location while still within the (context). 
	rem #######################################################################################################################	
	set "this=%~f0"
	set "A=%repo_path:/=\%"
	set "B=%repo_path:/=\%_BACKUP"
	if defined delete_repo (
		cd "%USERPROFILE%"
		move /Y "%A%" "%B%" & "!this:%A%=%B%!" continue
	)
	:continue
		
		if defined clone_repo ("%git.exe:/=\%" clone "%repo_url%" "%repo_path%")
		
		rem ###### Update ######
		"%git.exe:/=\%" -C "%repo_path%" pull --all
		"%git.exe:/=\%" -C "%repo_path%" checkout -- .
		"%git.exe:/=\%" -C "%repo_path%" checkout %repo_branch% || ( echo Remote has no '%repo_branch%' branch. )
			rem ###### Create Branch ######
			rem "%git.exe:/=\%" -C %repo_path% checkout -b %repo_branch% main
			rem "%git.exe:/=\%" -C %repo_path% push --set-upstream origin %repo_branch%

%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	rem %dk_call% dk_gitUpdate "ssh://u108565871@access912915170.webspace-data.io/~/DigitalKnob/Development.git" "%DIGITALKNOB_DIR%/Development"
	%dk_call% dk_gitUpdate
%endfunction%
