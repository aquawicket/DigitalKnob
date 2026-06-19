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


rem ##################################################################################
rem # dk_gitCheckRemote()
rem #
rem #
:dk_gitCheckRemote
%setlocal%

    %dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
    if NOT EXIST "%DKBRANCH_DIR%/.git" (%dk_call% dk_warning "%DKBRANCH_DIR%/.git NOT FOUND" && %return%)

	%dk_call% dk_validate git.exe %dk_call% dk_depend git

	%dk_call% git.exe -C %DKBRANCH_DIR% remote update
   
    %dk_call% dk_exec "%git.exe%" -C %DKBRANCH_DIR% rev-parse --abbrev-ref HEAD
	set "branch=%dk_exec%"
    %dk_call% dk_exec "%git.exe%" -C %DKBRANCH_DIR% rev-list --count origin/%branch%..%branch%
	set "ahead=%dk_exec%"
    %dk_call% dk_exec "%git.exe%" -C %DKBRANCH_DIR% rev-list --count %branch%..origin/%branch%
	set "behind=%dk_exec%"

    %dk_call% dk_echo "%ahead% commits ahead, %behind% commits behind"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

    %dk_call% dk_gitCheckRemote
%endfunction%
