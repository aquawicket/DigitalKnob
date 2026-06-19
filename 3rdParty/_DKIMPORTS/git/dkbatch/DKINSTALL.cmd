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

rem https://stackoverflow.com/a/67714373
%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
if NOT defined GIT_CONFIG_SYSTEM (set "GIT_CONFIG_SYSTEM=%DKCACHE_DIR%/.gitSystem")
if NOT defined GIT_CONFIG_GLOBAL (set "GIT_CONFIG_GLOBAL=%DKCACHE_DIR%/.gitGlobal")


rem ####################################################################
rem # DKINSTALL
rem #
:DKINSTALL
rem %setlocal%
	
	%dk_call% dk_import
	
	rem  https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	rem ############ DO NOT USE GIT_DIR ############
	if defined GIT_DIR (%dk_call% dk_fatal "ERROR: GIT_DIR should NOT be set")
	rem ############ DO NOT USE GIT_DIR ############
	
	if NOT defined git.exe 				(set "git.exe=%git%/bin/git.exe")
	rem if NOT defined bash_exe 			(set "bash_exe=%git%/bin/bash.exe")
	if NOT defined git_remote_https_exe (set "git_remote_https_exe=%git%/mingw64/libexec/git-core/git-remote-https.exe")
	%dk_call% dk_firewallAllow "%git_remote_https_exe%"
	rem if NOT defined git_bash_exe		(set "git_bash_exe=%git%/git-bash.exe")
	rem if NOT defined patch_exe			(set "patch_exe=%git%/usr/bin/patch.exe")
	

	if EXIST "%git.exe%" (%return%)
	
	rem ###### INSTALL ######
	"%dk_download%" -y -o "%git%"
	%dk_call% dk_assertPath "%git.exe%"
	
    rem ###### Install Git Context Menu ######
    %dk_call% dk_depend git/contextMenu
%endfunction%
