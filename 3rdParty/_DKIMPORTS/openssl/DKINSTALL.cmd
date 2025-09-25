@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0

	%dk_call% dk_import()
::	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
::	%dk_call% dk_set openssl_Import "https://github.com/openssl/openssl/archive/2f362e9.zip"
::	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
::	%dk_call% dk_importVariables %openssl_Import% IMPORT_PATH %DKIMPORTS_DIR%/openssl ROOT %DK3RDPARTY_DIR%

::	%dk_call% dk_basename %openssl_Import% openssl_Import_File
::	%dk_call% dk_removeExtension %openssl_Import_File% openssl_Import_Folder
::	set "openssl=%DK3RDPARTY_DIR%/openssl-%openssl_Import_Folder%"

::	if EXIST "%openssl%/Configure" (
::		echo "openssl already installed"
::		%return%
::	)
	::%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	::%dk_call% dk_download %openssl_Import% %DKDOWNLOAD_DIR%/openssl-2f362e9.zip
::	%dk_call% dk_download %openssl_Import%
::	%dk_call% dk_info "Installing %openssl_Install_Name%"

%endfunction%
