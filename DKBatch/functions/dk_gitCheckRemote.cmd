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


rem ##################################################################################
rem # dk_gitCheckRemote(repo_path)
rem #
rem #
:dk_gitCheckRemote
%setlocal%

	rem ### repo_path
	if "%repo_path%" equ "" (set "repo_path=%~1")
	if "%repo_path%" equ "" (
		%dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
		set "repo_path=!DKBRANCH_DIR!"
	)
	

	
    if NOT EXIST "%repo_path%\.git" (%dk_call% dk_warning "%repo_path%/.git NOT FOUND" && %return%)

	%dk_call% dk_validate git.exe %dk_call% dk_depend git

	"%git.exe%" -C %repo_path% remote update
   
    %dk_call% dk_exec "%git.exe%" -C %repo_path% rev-parse --abbrev-ref HEAD
	set "branch=%dk_exec%"
    %dk_call% dk_exec "%git.exe%" -C %repo_path% rev-list --count origin/%branch%..%branch%
	set "ahead=%dk_exec%"
    %dk_call% dk_exec "%git.exe%" -C %repo_path% rev-list --count %branch%..origin/%branch%
	set "behind=%dk_exec%"

    %dk_call% dk_echo "%ahead% commits ahead, %behind% commits behind"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_gitCheckRemote
%endfunction%
