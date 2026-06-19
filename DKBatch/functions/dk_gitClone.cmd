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

rem set "dk_gitClone_BACKUP=1"
rem ################################################################################
rem # dk_gitClone(repo_url, repo_path, repo_branch)
rem #
rem #
:dk_gitClone
%setlocal%
   
	rem ### repo_url
	if "%repo_url%" equ "" (set "repo_url=%~1")
	if "%repo_url%" equ "" (set "repo_url=%DKHttp_git_url%")
	if "%repo_url%" equ "" (set "repo_url=%DKSsh_git_url%")
	if "%repo_url%" equ "" (set "repo_url=http://aquawicket.com/DigitalKnob/Development.git")
	
	rem ### repo_branch
	if "%repo_branch%" equ "" (set "repo_branch=%~3")
	if "%repo_branch%" equ "" (set "repo_branch=Development")
	
	rem ### repo_path
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	if "%repo_path%" equ "" (set "repo_path=%~2")
	if "%repo_path%" equ "" (set "repo_path=%DKBRANCH_DIR%")
	if "%repo_path%" equ "" (
		%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
		set "repo_path=!DIGITALKNOB_DIR!/%repo_branch%"
	)
	

	rem ###### error if repository already exists
	if EXIST "%repo_path%/.git" (%dk_call% dk_notice "'%repo_path%/.git' repository already exists" && %return%)
		
	rem ###### backup if local path already exists
rem	if "%dk_gitClone_BACKUP%" equ "1" (
		if EXIST "%repo_path%" (
			%dk_call% dk_echo "Backing up %repo_path% . . ."
			%dk_call% dk_copy "%repo_path%" "%repo_path%_BACKUP" OVERWRITE
			if NOT EXIST ("%repo_path%_BACKUP" %dk_call% dk_fatal "dk_copy failed")
		)
rem	) else (
rem		%dk_call% dk_isEmptyDirectory "%repo_path%" || (%dk_call% dk_delete "%repo_path%")
rem	)
	
	%dk_call% dk_validate git.exe %dk_call% dk_depend git
	
	rem ###### Clone if directory doesn't EXIST or is empty
	%dk_call% dk_mkdir "%repo_path%"
	%dk_call% dk_isEmptyDirectory "%repo_path%" && ("%git.exe%" -C "%repo_path%" clone %repo_url% "%repo_path%" && %return%)
	
	rem ###### Fetch and checkout if directory already exists and is NOT empty
rem	"%git.exe%" -C "%repo_path%" init -b %repo_branch%
rem	"%git.exe%" -C "%repo_path%" remote add origin %repo_url%
rem	"%git.exe%" -C "%repo_path%" fetch
rem	"%git.exe%" -C "%repo_path%" checkout -t origin/%repo_branch% -f
	
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	rem %dk_call% dk_assertVar DKStorage_Dir
	rem %dk_call% dk_assertVar DIGITALKNOB_DIR
	rem %dk_call% dk_gitClone "%DKGit_gitbundle%" "%DIGITALKNOB_DIR%/Development"
	
	rem %dk_call% dk_assertVar DIGITALKNOB_DIR
	rem %dk_call% dk_gitClone "%DKSsh_git_url%" "%DIGITALKNOB_DIR%/Development"
	
	%dk_call% dk_gitClone
%endfunction%
