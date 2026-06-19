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


set "dk_gitUpdate_BACKUP=1"
rem ################################################################################
rem # dk_gitUpdate(url, branch, NO_CONFIRM)
rem #
rem #
:dk_gitUpdate
%setlocal%
	
	rem if NOT defined DKStorage_Dir (set "DKStorage_Dir=%DIGITALKNOB_DIR%/DKStorage")
	rem if NOT EXIST "%DKGit_gitbundle%" (
		%dk_call% dk_download "%DKHttp_gitbundle%" "%DKGit_gitbundle%"
	rem )
		
	rem ### git_url ###
    if "%~1" neq "" (set "git_url=%~1") 	else (set "git_url=%DKStorage_Dir%/DigitalKnob.bundle")
	%dk_call% dk_debug "git_url = %git_url%"
    
	rem ### DKBRANCH ###
	
	if "%~2" neq "" (set "DKBRANCH=%~2") 	else (set "DKBRANCH=Development")
	%dk_call% dk_debug "DKBRANCH = %DKBRANCH%"
   
    rem if "%3" neq "NO_CONFIRM" (
    rem     echo Git Update? Any local changes will be lost.
    rem     %dk_call% dk_confirm || %return%
    rem )

    rem %dk_call% dk_validate git.exe %dk_call% dk_depend git
   
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
    if NOT EXIST "%DKBRANCH_DIR%/.git" (

		if EXIST "%DKBRANCH_DIR%" (
		
			rem ###### Backup Branch directory and clone ######
			if "%dk_gitUpdate_BACKUP%" equ "1" (
				%dk_call% dk_copy "%DKBRANCH_DIR%" "%DKBRANCH_DIR%_BACKUP" OVERWRITE
			)
			set "delete_repo=1"
		)
		rem ####################################################################
		set "clone_repo=1"	
	)
	
	rem #######################################################################################################################	
	rem NOTE: 	This must clone and update within the parentheses. rd /s /q "%DKBRANCH_DIR%" removes the current DigitalKnob
	rem			folder, leaving the current running batch process abandoned until it's cloned again. It seems like when we are
	rem 		in the scope of called batch files, we loose all references to those deleted file once we leave the parentheses.
	rem         This includes variables, functions, etc. So to fix this, after we delete the very files our context is running
	rem			from, we must stay in parentheses until those files are restored and updated, or we will lose the context.
	rem #######################################################################################################################	
	(
		if defined delete_repo (
			%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
			set "PATH=%DKBRANCH_DIR%_BACKUP/DKBatch/functions;%PATH%"
			cd "!DIGITALKNOB_DIR!"
			rd /s /q "%DKBRANCH_DIR%"
		)
		if defined clone_repo (%dk_call% git.exe clone %git_url% "%DKBRANCH_DIR%)
		
		rem ###### Update ######
		%dk_call% git.exe -C %DKBRANCH_DIR% pull --all
		%dk_call% git.exe -C %DKBRANCH_DIR% checkout -- .
		%dk_call% git.exe -C %DKBRANCH_DIR% checkout %DKBRANCH% || (
			echo Remote has no '%DKBRANCH%' branch.
			rem ###### Create Branch ######
			rem %dk_call% git.exe -C %DKBRANCH_DIR% checkout -b %DKBRANCH% main
			rem %dk_call% git.exe -C %DKBRANCH_DIR% push --set-upstream origin %DKBRANCH%
		)
		%return%
	)
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_gitUpdate
    rem %dk_call% dk_gitUpdate %REPO_URL% Development
	
%endfunction%
