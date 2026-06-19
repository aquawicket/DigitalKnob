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


rem ####################################################################
rem # DKINSTALL()
rem #
:DKINSTALL

	%dk_call% dk_import()
rem 	%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR
rem 	%dk_call% dk_set openssl_Import "https://github.com/openssl/openssl/archive/2f362e9.zip"
rem 	%dk_call% dk_validate DK3RDPARTY_DIR %dk_call% dk_DK3RDPARTY_DIR
rem 	%dk_call% dk_importVariables %openssl_Import% IMPORT_PATH %DKIMPORTS_DIR%/openssl ROOT %DK3RDPARTY_DIR%

rem 	%dk_call% dk_basename %openssl_Import% openssl_Import_File
rem 	%dk_call% dk_removeExtension %openssl_Import_File% openssl_Import_Folder
rem 	set "openssl=%DK3RDPARTY_DIR%/openssl-%openssl_Import_Folder%"

rem 	if EXIST "%openssl%/Configure" (
rem 		echo "openssl already installed"
rem 		%return%
rem 	)
	rem %dk_call% dk_validate DKDOWNLOAD_DIR %dk_call% dk_DKDOWNLOAD_DIR
	rem %dk_call% dk_download %openssl_Import% %DKDOWNLOAD_DIR%/openssl-2f362e9.zip
rem 	%dk_call% dk_download %openssl_Import%
rem 	%dk_call% dk_info "Installing %openssl_Install_Name%"

%endfunction%
