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
rem # dk_sftpUpload(localPath remotePath) OVERWRITE
rem #
rem # 	Reference: https://man7.org/linux/man-pages/man1/sftp.1.html
rem #
:dk_sftpUpload
	if NOT DEFINED dk_sftpUpload_APP (set "dk_sftpUpload_APP=curl")   &rem curl, openssh 
%setlocal%
 
	rem ### localPath
	set "localPath=%~1"
	%dk_call% dk_assertPath "%localPath%"
	rem %dk_call% dk_debug "localPath = %localPath%"
	
	rem ### remotePath
	set "remotePath=%~2"
	%dk_call% dk_assertVar remotePath
	rem %dk_call% dk_debug "remotePath = %remotePath%"
	
	rem ### remoteDir
	for %%Z in ("%remotePath%") do set "remoteDir=%%~pZ"
	%dk_call% dk_assertVar remoteDir
	rem %dk_call% dk_debug "remoteDir = %remoteDir%"
	
	rem ### DKSftp file
	%dk_call% dk_validate DIGITALKNOB_DIR %dk_call% dk_DIGITALKNOB_DIR
	%dk_call% dk_fileVariables "%DIGITALKNOB_DIR%/DKStorage/DKSftp"

	rem ### FIXME ###
	rem ### We are having trouble with dk_fileVariables and !'s
	rem ### dk_fileVariable works if we use ^! instead of !
	%dk_call% dk_fileVariable "%DIGITALKNOB_DIR%/DKStorage/DKSftp" DKSftp_pass
	
	rem ### DKSftp_server
	if "%DKSftp_server%" equ "" (
		%dk_call% dk_echo "enter sftp server address . . ."
		set /p "DKSftp_server="
	)
	%dk_call% dk_assertVar DKSftp_server
	
	rem ### DKSftp_PORT
	if "%DKSftp_PORT%" equ "" (
		%dk_call% dk_echo "enter sftp port . . ."
		set /p "DKSftp_PORT="
	)
	%dk_call% dk_assertVar DKSftp_PORT
	
	rem ### DKSftp_user
	if "%DKSftp_user%" equ "" (
		%dk_call% dk_echo "enter sftp username . . ."
		set /p "DKSftp_user="
	)
	%dk_call% dk_assertVar DKSftp_user

	rem ### DKSftp_pass
	if "%DKSftp_pass%" equ "" (
		%dk_call% dk_echo "enter sftp password . . ."
		set /p "DKSftp_pass="
	)
	%dk_call% dk_assertVar DKSftp_pass
	

	rem ### Use sftp.exe
	if /i "%dk_sftpUpload_APP%" equ "openssh" (
		%dk_call% dk_validate sftp_exe %dk_call% dk_depend OpenSSH
		echo put %localPath:\=/% | %sftp_exe% %DKSftp_user%@%DKSftp_server%:%remoteDir:\=/%
	
	rem ### Use curl.exe (DEFAULT)
	rem # https://www.filestash.app/sftp-curl.html
	) else (
		rem	%dk_call% dk_validate curl %dk_call% dk_depend curl
		set "curl.exe="
		%dk_call% dk_validate curl.exe %dk_call% dk_depend curl.exe
		%dk_call% curl.exe --upload-file %localPath:\=/% -k sftp://%DKSftp_server%%remoteDir:\=/%/ --user %DKSftp_user%:!DKSftp_pass!
		 %return%
	)

%endfunction%











rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%

	%dk_call% dk_validate DKDOWNLOAD_DIR	%dk_call% dk_DKDOWNLOAD_DIR
	%dk_call% dk_sftpUpload "%DKDOWNLOAD_DIR%/PortableGit-2.46.2-64-bit.7z.exe" "/DigitalKnob/download/PortableGit-2.46.2-64-bit.7z.exe"

%endfunction%

