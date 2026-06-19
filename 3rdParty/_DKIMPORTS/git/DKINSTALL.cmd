rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	if NOT DEFINED DK.cmd (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	call "%%DK.cmd:/=\%%" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


rem ####################################################################
rem # DKINSTALL
rem #
:DKINSTALL
	rem  https://stackoverflow.com/a/67714373
	%dk_call% dk_validate DKCACHE_DIR %dk_call% dk_DKCACHE_DIR
	if NOT defined GIT_CONFIG_SYSTEM (set "GIT_CONFIG_SYSTEM=%DKCACHE_DIR%/.gitSystem")
	if NOT defined GIT_CONFIG_GLOBAL (set "GIT_CONFIG_GLOBAL=%DKCACHE_DIR%/.gitGlobal")
%setlocal%
	
	%dk_call% dk_import
	
	rem  https://stackoverflow.com/questions/15769263/how-does-git-dir-work-exactly
	rem ############ DO NOT USE GIT_DIR ############
	if defined GIT_DIR (%dk_call% dk_fatal "ERROR: GIT_DIR should NOT be set")
	rem ############ DO NOT USE GIT_DIR ############
	
	rem if NOT defined bash_exe 		(set "bash_exe=%git%/bin/bash.exe")
	rem if NOT defined git_exe 			(set "git_exe=%git%/bin/git.exe")
	if NOT defined git.exe 				(set "git.exe=%git%/bin/git.exe")
	if NOT defined git_bash_exe			(set "git_bash_exe=%git%/git-bash.exe")
	if NOT defined git_remote_http_exe  (set "git_remote_http_exe=%git%/mingw64/libexec/git-core/git-remote-http.exe")
	if NOT defined git_remote_https_exe (set "git_remote_https_exe=%git%/mingw64/libexec/git-core/git-remote-https.exe")
	if NOT defined git_ssh_exe			(set "git_ssh_exe=%git%/usr/bin/ssh.exe")
	rem if NOT defined patch_exe		(set "patch_exe=%git%/usr/bin/patch.exe")

	%dk_call% dk_firewallAllow "%git_remote_http_exe%"
	%dk_call% dk_firewallAllow "%git_remote_https_exe%"
	%dk_call% dk_firewallAllow "%git_ssh_exe%"
	
	rem ###### INSTALL ######
	if EXIST "%git.exe%" (goto:return)
	"%dk_import%" -y -o "%git%"
	%dk_call% dk_assertPath "%git.exe%"
	
    rem ###### Install Git Context Menu ######
    %dk_call% dk_depend git/contextMenu
	
	:return
	endlocal & (
		set "git=%git%"
		set "git.exe=%git.exe%"
		set "git_bash_exe=%git_bash_exe%"
		set "git_ssh_exe=%git_ssh_exe%"
	)
%endfunction%
