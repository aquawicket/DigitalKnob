@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	%endfuncion%
	exit /b %errorlevel%
)
%endfuncion%
rem #################################################################################################################################################


rem ################################################################################
rem # BACKUP()
rem #
rem #
:BACKUP
%setlocal%
 
	%dk_call% git.exe --version
	%dk_call% curl.exe --version
	
	rem ######### Local Repository ########
	set "Branch=Development"
	set "Local_Repo=%USERPROFILE:\=/%/Digital Knob/%Branch%"
	
	rem ###### Create Remote Repository List ######
	call :CreateRemoteList
	call :AddRemote "ssh://u108565871@access912915170.webspace-data.io/~/DigitalKnob/%Branch%"
	call :AddRemote "https://github.com/aquawicket/DigitalKnob"
	
	echo.
	echo ###### Git remote push list ######
	%dk_call% git.exe -C "%Local_Repo%" remote get-url --push --all origin
	echo ####################################
	
	echo.
	echo ###### Git safe.direcoty list ######
	rem %dk_call% git.exe -C "%Local_Repo%" config --global --get safe.directory	# DEPRECATED
	%dk_call% git.exe -C "%Local_Repo%" config get --global safe.directory
	echo ####################################
	
	
	call :GIT_COMMIT
	rem call :GIT_UPDATE
	rem call :BACKUP_FILES
  
%endfuncion%
exit /b %errorlevel%






rem ################################################################################
rem # CreateRemoteList()
rem #
rem #
:CreateRemoteList
%setlocal%
	
	echo.
	echo ###### Clean remote list #######
	for /f "delims=" %%G in ('%dk_start% "%git.exe%" -C "%Local_Repo%" remote get-url --push --all origin') do (
		%dk_call% dk_exists "%%~G" || (
			%dk_call% dk_notice "%%~G NOT FOUND, REMOVING . . ."
			%dk_call% git.exe -C "%Local_Repo%" remote set-url origin --push --delete "%%~G" 2>nul
		)
	)	
	
	echo.
	echo ##### Clean safe.directory list ######
	for /f "delims=" %%G in ('%dk_start% "%git.exe%" -C "%Local_Repo%" config get --global safe.directory') do (
		if NOT EXIST "%%~G" (
			%dk_call% dk_notice "%%~G NOT FOUND, REMOVING . . ."
			%dk_call% git.exe -C "%Local_Repo%" config --global --unset safe.directory "%%~G"		&rem # DEPRECATED
			rem %dk_call% git.exe -C "%Local_Repo%" config unset --global "%%~G" safe.directory
		)
	)	
	
	echo.
	echo ###### Find Local remote push repositories ######
	for %%i in (A B C D E F G H J J K L M N O P Q R S T U V W X Y Z) do (
		if EXIST "%%i:/DigitalKnob/%Branch%.git" (
			call :AddRemote "%%i:/DigitalKnob/%Branch%.git"
		)
	)
%endfuncion%
exit /b %errorlevel%


rem ################################################################################
rem # AddRemote(url)
rem #
rem #
:AddRemote
%setlocal%
	set "remoteInList=false"
	for /f "delims=" %%G in ('%dk_start% "%git.exe%" -C "%Local_Repo%" remote get-url --push --all origin') do (
		if "%~1" equ "%%~G" (
			set "remoteInList=true"
		)
	)	
	if "%remoteInList%" neq "true" (
		%dk_call% dk_exists "%~1" && (
			%dk_call% dk_notice "Adding remote: %~1"
			%dk_call% git.exe -C "%Local_Repo%" remote set-url origin --push --add "%~1"
		)
	) else (
		%dk_call% dk_exists "%~1" || (
			%dk_call% dk_notice "Deleting remote: %~1"
			%dk_call% git.exe -C "%Local_Repo%" remote set-url origin --push --delete "%~1"
		)
	)
	
	
	
	set "safeDirInList=false"
	rem for /f "delims=" %%G in ('%dk_start% "%git.exe%" -C "%Local_Repo%" config --global --get safe.directory') do (	# DEPRECATED
	for /f "delims=" %%G in ('%dk_start% "%git.exe%" -C "%Local_Repo%" config get --global safe.directory') do (
		if "%~1" equ "%%~G" (
			set "safeDirInList=true"
		)
	)		
	if "%safeDirInList%" neq "true" (
		if EXIST "%~1" (
			%dk_call% dk_notice "Adding safe.directory: %~1"
			%dk_call% git.exe -C "%Local_Repo%" config --global --add safe.directory "%~1"		&rem # DEPRECATED
			rem %dk_call% git.exe -C "%Local_Repo%" config set --global --append safe.directory "%~1"
		)
	) else (
		if NOT EXIST "%~1" (
			%dk_call% dk_notice "Removing safe.directory: %~1"
			%dk_call% git.exe -C "%Local_Repo%" config --global --unset safe.directory "%~1"	&rem # DEPRECATED
			rem %dk_call% git.exe -C "%Local_Repo%" config unset --global "%~1" safe.directory
		)
	)
%endfuncion%
exit /b %errorlevel%


rem ################################################################################
rem # GIT_COMMIT()
rem #
rem #
:GIT_COMMIT
%setlocal%

	echo.
	echo ###### Commit local repository ######
	set "commit_msg=git commit %date% %time%"
	echo commit message: '%commit_msg%'
	%dk_call% git.exe -C "%Local_Repo%" commit -a -m "%commit_msg%"
	rem %dk_call% dk_debug "git.exe = '%git.exe%'"
	
	rem ### Backup the repository to  bundle file
	rem	%dk_call% dk_gitBundle "%Local_Repo%" "%DKGit_gitbundle%" OVERWRITE
	rem %dk_call% dk_sftpUpload "%DKGit_gitbundle%" "%DKSftp_gitbundle%"
	
	rem ### Backup the HEAD to a tar.gz file
	rem %dk_call% git.exe -C "%Local_Repo%" archive --format=tar.gz -0 HEAD --output="%DKGit_targz%"
	rem rem %dk_call% dk_sftpUpload "%DKGit_targz%" "%DKSftp_git_targz%"
	
	echo.
	%dk_call% dk_notice "###### Git push ######"
	%dk_call% dk_notice "Local_Repo: '%Local_Repo%'"
	%dk_call% git.exe -C "%Local_Repo%" push -f
	rem %dk_call% dk_sshpass git.exe -C "%Local_Repo%" push -f
%endfuncion%
exit /b %errorlevel%


rem ################################################################################
rem # GIT_UPDATE()
rem #
:GIT_UPDATE
%setlocal%
   
	if NOT EXIST "%repo_target%/.git" (
		if EXIST "%repo_target%" (set "delete_repo_target=1")
		set "clone_Local_Repo=1"	
	)
	
	rem #######################################################################################################################	
	rem NOTE: 	This must clone and update within the parentheses. rd /s /q "%repo_target%" removes the current DigitalKnob
	rem			folder, leaving the current running batch process abandoned until it's cloned again. It seems like when we are
	rem 		in the scope of called batch files, we loose all references to those deleted file once we leave the parentheses.
	rem         This includes variables, functions, etc. So to fix this, after we delete the very files our context is running
	rem			from, we must stay in parentheses until those files are restored and updated, or we will lose the context.
	rem #######################################################################################################################	
	(
		rem if defined delete_repo_target (rd /s /q "%repo_target%")
		if defined clone_Local_Repo (%dk_call% git.exe clone "%Local_Repo%" "%repo_target%")
		
		rem ###### Update ######
		rem %dk_call% git.exe -C "%repo_target%" config --global --add safe.directory "%repo_target%"		# DEPRECATED
		%dk_call% git.exe -C "%repo_target%" config set --global --append safe.directory "%repo_target%"
		%dk_call% git.exe -C "%repo_target%" stash
		%dk_call% git.exe -C "%repo_target%" pull --all
		%dk_call% git.exe -C "%repo_target%" checkout -- .
		%dk_call% git.exe -C "%repo_target%" checkout %Branch% || (
			echo ERROR:%errorlevel% @ 'git.exe -C "%repo_target%" checkout %Branch%'
			exit /b %errorlevel%
		)
		exit /b %errorlevel%
	)
%endfuncion%
exit /b %errorlevel%


rem ################################################################################
rem # BACKUP_FILES()
rem #
rem #
:BACKUP_FILES
%setlocal%

	rem  /E                  :: copy subdirectories, including Empty ones.
	rem  /COPY:DT			 :: copyflags : D=Data, A=Attributes, T=Timestamps
	rem  /XD dirs [dirs]...  :: eXclude Directories matching given names/paths.
	rem  /NS                 :: No Size - don't log file sizes.
	rem  /NC                 :: No Class - don't log file classes.
	%dk_call% dk_dirname "!Local_Repo!" Local_DK_Dir
	
	set /a "_index_=0"
	:array_loop3
		if NOT defined Remote_Repo[%_index_%] (goto :end_array_loop3)
	
		%dk_call% dk_dirname "!Remote_Repo[%_index_%]!" Remote_DK_Dir
		
		echo.
		%dk_call% dk_notice "###### Backup files ######"
		%dk_call% dk_notice "Local_DK_Dir: '%Local_DK_Dir%'"
		%dk_call% dk_notice "Remote_DK_Dir: '%Remote_DK_Dir%'"
		%dk_call% robocopy.exe "%Local_DK_Dir:/=\%" "%Remote_DK_Dir:/=\%" /E /COPY:DAT /XD .dk %Branch% %Branch%.git DKTools BUILD %Branch%_BACKUP NS /NC /FFT
		
		set /a "_index_+=1"
		goto array_loop3
	:end_array_loop3
    
%endfuncion%
exit /b %errorlevel%



rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	call :BACKUP
	
%endfuncion%
exit /b %errorlevel%
