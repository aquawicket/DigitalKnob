@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::%setlocal%
	%dk_call% dk_debugFunc 0

	set "macro_pack_Import=https://github.com/sevagas/macro_pack/releases/download/v2.2.0/macro_pack.exe"
	if NOT defined macro_pack_Import (%dk_call% dk_error "macro_pack_Import is invalid")
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %macro_pack_Import% IMPORT_PATH %DKIMPORTS_DIR%/macro_pack
	%dk_call% dk_set macro_pack_exe "%macro_pack%/%macro_pack_IMPORT_FILE%"
	
	if EXIST "%macro_pack_exe%" (%return%)
	%dk_call% dk_echo
	%dk_call% dk_info "Installing macro_pack . . ."
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_download %macro_pack_Import%
	%dk_call% dk_copy "%dk_download%" "%macro_pack%/%macro_pack_IMPORT_FILE%"
	if NOT EXIST "%macro_pack_exe%" (%dk_call% dk_error "cannot find macro_pack_exe:%macro_pack_exe%")

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%
