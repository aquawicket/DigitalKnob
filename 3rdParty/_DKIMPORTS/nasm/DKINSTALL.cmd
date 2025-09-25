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
	
	%dk_call% dk_set nasm_Import "https://github.com/microsoft/vcpkg/files/12073957/nasm-2.16.01-win64.zip"
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_importVariables %nasm_Import% IMPORT_PATH %DKIMPORTS_DIR%\nasm ROOT %DK3RDPARTY_DIR%

::	%dk_call% dk_basename %nasm_Import% nasm_Import_File
::	%dk_call% dk_removeExtension %nasm_Import_File% nasm_Import_Folder
	
::	set "nasm=%DK3RDPARTY_DIR%\nasm-%nasm_Import_Folder%"
	
	if EXIST %nasm%\Configure" (
		echo "nasm already installed"
		%return%
	)
	%dk_call% dk_download %nasm_Import%
	
	%dk_call% dk_info "Installing %nasm_Install_Name%"
	
	:: %dk_call% dk_debug "nasm = %nasm%"
%endfunction%
