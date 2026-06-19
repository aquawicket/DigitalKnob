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


rem ############ OpenSSH ############
rem # https://github.com/PowerShell/Win32-OpenSSH/releases/download/v9.8.3.0p2-Preview/OpenSSH-Win64.zip

:DKINSTALL
rem %setlocal%

	%dk_call% dk_import
	
	%dk_call% dk_set sftp_exe "%OpenSSH%/sftp.exe"
	%dk_call% dk_debug "sftp_exe = %sftp_exe%"
	
	%dk_call% dk_set ssh_exe "%OpenSSH%/ssh.exe"
	%dk_call% dk_debug "ssh_exe = %ssh_exe%"
	
	%dk_call% dk_firewallAllow "%ssh_exe%"
%endfunction%
