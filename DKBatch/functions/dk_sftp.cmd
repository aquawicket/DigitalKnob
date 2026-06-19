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


rem ############################################################################
rem # dk_sftp()
rem #
rem # 	Reference: https://man7.org/linux/man-pages/man1/sftp.1.html
rem #
:dk_sftp
%setlocal%
 
	%dk_call% dk_validate sftp_exe %dk_call% dk_depend OpenSSH
	
	set "user=%DKSftp_user%"
	set "server=%DKSftp_server%"
	set "port=%DKSftp_port%"
	set "local_path=%DKGit_gitbundle%"
	set "remote_path=%DKSftp_gitbundle%"
	for %%Z in ("%remote_path%") do set "remote_dir=%%~pZ"
	
	%dk_call% dk_debug "user = %user%"
	%dk_call% dk_debug "server = %server%"
	%dk_call% dk_debug "port = %port%"
	%dk_call% dk_debug "local_path = %local_path%"
	%dk_call% dk_debug "remote_path = %remote_path%"
	%dk_call% dk_debug "remote_dir = %remote_dir%"
	
	rem ###### CONNECT ######
	rem ssh u108565871@access912915170.webspace-data.io
	rem %sftp_exe% %user%@%server%
	
	rem ##### CONNECT & DOWNLOAD #####
	rem echo %sftp_exe% %user%@%server%:%remote_path:\=/% %local_path:\=/%
	rem %sftp_exe% %user%@%server%:%remote_path:\=/% %local_path:\=/%
	
	rem ###### CONNECT & UPLOAD ######
	rem echo put %local_path:\=/% ^| %sftp_exe% %user%@%server%:%remote_dir:\=/%
	%dk_call% dk_assertPath "%local_path%"	
	echo put %local_path:\=/% | %sftp_exe% %user%@%server%:%remote_dir:\=/%
%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_sftp

%endfunction%

