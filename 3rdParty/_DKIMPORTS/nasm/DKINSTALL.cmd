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

	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	
	%dk_call% dk_set NASM_DL "https://github.com/microsoft/vcpkg/files/12073957/nasm-2.16.01-win64.zip"
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_importVariables %NASM_DL% IMPORT_PATH %DKIMPORTS_DIR%\nasm ROOT %DK3RDPARTY_DIR%

::	%dk_call% dk_basename %NASM_DL% NASM_IMPORT_FILE
::	%dk_call% dk_removeExtension %NASM_IMPORT_FILE% NASM_FOLDER
	
::	set "NASM=%DK3RDPARTY_DIR%\nasm-%NASM_FOLDER%"
	
	if EXIST %NASM%\Configure" (
		echo "nasm already installed"
		%return%
	)
	%dk_call% dk_download %NASM_DL%
	
	%dk_call% dk_info "Installing %NASM_FOLDER%"
	
	:: TODO
	:: %dk_call% dk_printVar NASM
	:: %dk_download% = path to the downloaded file 
%endfunction%
