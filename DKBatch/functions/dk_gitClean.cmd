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
rem # dk_gitClean(repo_path)
rem #
rem #
:dk_gitClean
%setlocal%
	
	rem ### repo_path
	if "%repo_path%" equ "" (set "repo_path=%~1")
	if "%repo_path%" equ "" (
		%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
		set "repo_path=!DKBRANCH_DIR!"
	)
	
    %dk_call% dk_validate git.exe %dk_call% dk_depend git
    "%git.exe%" -C %repo_path% clean -fdx
%endfunction%




rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_gitClean
%endfunction%
