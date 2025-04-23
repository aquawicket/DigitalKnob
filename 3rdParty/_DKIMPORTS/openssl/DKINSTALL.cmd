@echo off&::########################################## DigitalKnob DKBatch ########################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*) 
::#################################################################################################################################################


::####################################################################
::# DKINSTALL()
::#
:DKINSTALL
	%dk_call% dk_debugFunc 0

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_set OPENSSL_DL "https://github.com/openssl/openssl/archive/2f362e9.zip"
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_importVariables %OPENSSL_DL% IMPORT_PATH %DKIMPORTS_DIR%/openssl ROOT %DK3RDPARTY_DIR%

::	%dk_call% dk_basename %OPENSSL_DL% OPENSSL_DL_FILE
::	%dk_call% dk_removeExtension %OPENSSL_DL_FILE% OPENSSL_FOLDER
::	set "OPENSSL=%DK3RDPARTY_DIR%/openssl-%OPENSSL_FOLDER%"

	if exist %OPENSSL%/Configure" (
		echo "openssl already installed"
		%return%
	)
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_download %OPENSSL_DL% %DKDOWNLOAD_DIR%/openssl-2f362e9.zip
	%dk_call% dk_info "Installing %OPENSSL_FOLDER%"

%endfunction%
