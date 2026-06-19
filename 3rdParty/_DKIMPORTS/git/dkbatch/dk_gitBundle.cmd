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
rem # dk_gitBundle(repo_path, bundle_file) OVERWRITE
rem #
rem #
:dk_gitBundle
%setlocal%
   
	if "%~1" neq "" (set "repo_path=%~1")
	if "%~2" neq "" (set "bundle_file=%~2")
	if /i "%~3" equ "OVERWRITE" (set "OVERWRITE=1") else (set "OVERWRITE=0")

	rem ###### error if repository doesn't exist
	if NOT EXIST "%repo_path%/.git" (
		%dk_call% dk_error "%repo_path% is not a path to a repository"
		%return%
	)
		
	if EXIST "%bundle_file%" (
		if "%OVERWRITE%" neq "1" (
			%dk_call% dk_error "dk_gitBundle Cannot create backup. Destiantion already exists and OVERWRITE is NOT set"
		)
		%dk_call% dk_delete "%bundle_file%"
	)
	
	rem ###### Back up the repositiory to a bundle_file
	%dk_call% git.exe -C "%repo_path%" bundle create "%bundle_file%" --all
	
	rem %dk_call% dk_sftpUpload "%bundle_file%" 
	
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
    %dk_call% dk_gitBundle "%DKBRANCH_DIR%" "%DKStorage_Dir%/DigitalKnob.bundle" OVERWRITE

%endfunction%
