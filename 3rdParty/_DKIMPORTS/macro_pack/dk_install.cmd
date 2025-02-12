@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)


::####################################################################
::# dk_install
::#
:dk_install
::setlocal
	%dk_call% dk_debugFunc 0
 
    set "MACRO_PACK_DL=https://github.com/sevagas/macro_pack/releases/download/v2.2.0/macro_pack.exe"
	if not defined MACRO_PACK_DL   %dk_call% dk_error "MACRO_PACK_DL is invalid"
	
	%dk_call% dk_validate DKTOOLS_DIR "%dk_call% dk_DKTOOLS_DIR"
	%dk_call% dk_importVariables %MACRO_PACK_DL% IMPORT_PATH %DKIMPORTS_DIR%\macro_pack
	%dk_call% dk_set MACRO_PACK_EXE "%MACRO_PACK_DIR%\%MACRO_PACK_DL_FILE%"
	
	if exist "%MACRO_PACK_EXE%" %return%
	%dk_call% dk_echo   
    %dk_call% dk_info "Installing MACRO_PACK . . ."
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
    %dk_call% dk_download %MACRO_PACK_DL%
	%dk_call% dk_copy "%DKDOWNLOAD_DIR%\%MACRO_PACK_DL_FILE%" "%MACRO_PACK%\%MACRO_PACK_DL_FILE%"
	if NOT exist "%MACRO_PACK_EXE%" %dk_call% dk_error "cannot find MACRO_PACK_EXE:%MACRO_PACK_EXE%"

%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0
 
	%dk_call% dk_install
%endfunction%
