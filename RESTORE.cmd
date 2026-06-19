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
rem # RESTORE()
rem #
rem #
:RESTORE
%setlocal%
  
	rem ######### Local DigitalKnob Folder ########
	set "Branch=Development"
	set "Local_Repo=%USERPROFILE:\=/%/Digital Knob/%Branch%"

	rem ###### Remote DigitalKnob Folders ######
	for %%i in (A B C D E F G H J J K L M N O P Q R S T U V W X Y Z) do (
		if EXIST "%%i:/DigitalKnob/%Branch%.git" (
			%dk_call% Array/dk_push Remote_Repo "%%i:/DigitalKnob/%Branch%"
		)
	)
	
	%dk_call% Array/dk_push Remote_Repo "ssh://u108565871@access912915170.webspace-data.io/~/DigitalKnob/%Branch%"
rem	%dk_call% Array/dk_push Remote_Repo "https://github.com/aquawicket/DigitalKnob"

	set /a "_index_=0"
	:array_loop1
		if NOT defined Remote_Repo[%_index_%] (goto :end_array_loop1)
		%dk_call% dk_debug "Remote_Repo[%_index_%]: '!Remote_Repo[%_index_%]!'"

		set /a "_index_+=1"
		goto array_loop1
	:end_array_loop1
	
	
	call :GIT_COMMIT
	call :RESTORE_FILES
  
%endfuncion%
exit /b %errorlevel%


rem ################################################################################
rem # GIT_COMMIT()
rem #
rem #
:GIT_COMMIT
%setlocal%
	
	set "commit_msg=git commit %date%"
	echo commit message: '%commit_msg%'

	rem ### Commit local repository
	%dk_call% git.exe -C "%Local_Repo:/=\%" commit -a -m "%commit_msg%"
	
	rem ### Backup the repository to  bundle file
	rem	%dk_call% dk_gitBundle "%Local_Repo%" "%DKGit_gitbundle%" OVERWRITE
	rem %dk_call% dk_sftpUpload "%DKGit_gitbundle%" "%DKSftp_gitbundle%"
	
	rem ### Backup the HEAD to a tar.gz file
	rem %dk_call% git.exe -C "%Local_Repo%" archive --format=tar.gz -0 HEAD --output="%DKGit_targz%"
	rem rem %dk_call% dk_sftpUpload "%DKGit_targz%" "%DKSftp_git_targz%"
	
	set /a "_index_=0"
	:array_loop2
		if NOT defined Remote_Repo[%_index_%] (goto :end_array_loop2)
		
		echo.
		%dk_call% dk_notice "###### Git push ######"
		%dk_call% dk_notice "Local_Repo: '%Local_Repo%'"
		%dk_call% dk_notice "Remote_Repo[%_index_%]: '!Remote_Repo[%_index_%]!'"
		%dk_call% git.exe -C "%Local_Repo%" remote set-url origin !Remote_Repo[%_index_%]!
		%dk_call% git.exe -C "%Local_Repo%" push
		
		set /a "_index_+=1"
		goto array_loop2
	:end_array_loop2
  
%endfuncion%
exit /b %errorlevel%


rem ################################################################################
rem # RESTORE_FILES()
rem #
rem #
:RESTORE_FILES
%setlocal%

	rem  /E                  :: copy subdirectories, including Empty ones.
	rem  /COPY:DT			 :: copyflags : D=Data, A=Attributes, T=Timestamps
	rem  /XD dirs [dirs]...  :: eXclude Directories matching given names/paths.
	rem  /NS                 :: No Size - don't log file sizes.
	rem  /NC                 :: No Class - don't log file classes.
	%dk_call% dk_dirname "!Local_Repo!" Local_DK_Dir
	
rem	set /a "_index_=0"
rem	:array_loop3
rem		if NOT defined Remote_Repo[%_index_%] (goto :end_array_loop3)
	
		%dk_call% dk_dirname "!Remote_Repo[0]!" Remote_DK_Dir
		
		echo.
		%dk_call% dk_notice "###### Restore files ######"
		%dk_call% dk_notice "Remote_DK_Dir: '%Remote_DK_Dir%"
		%dk_call% dk_notice "Local_DK_Dir: '%Local_DK_Dir%'"
		%dk_call% robocopy.exe "%Remote_DK_Dir%" "%Local_DK_Dir%" /E /COPY:DAT /XD %Branch% %Branch%.git %Branch%_BACKUP BUILD DKTools NS /NC /FFT
		
rem		set /a "_index_+=1"
rem		goto array_loop3
rem	:end_array_loop3
    
%endfuncion%
exit /b %errorlevel%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	call :RESTORE

%endfuncion%
exit /b %errorlevel%

