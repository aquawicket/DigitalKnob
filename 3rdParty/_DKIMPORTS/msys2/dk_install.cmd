@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ set "DKBATCH_FUNCTIONS_DIR_=..\..\..\DKBatch\functions\"
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

::####################################################################
::# dk_install
::#
:dk_install
	%dk_call% dk_debugFunc 0
	
	::%dk_call% dk_set MSYS2_DL "https://github.com/msys2/msys2-installer/releases/download/2024-07-27/msys2-x86_64-20240727.exe"
	%dk_call% dk_getFileParam %~dp0\dkconfig.txt MSYS2_DL
	
	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_importVariables %MSYS2_DL% IMPORT_PATH %DKIMPORTS_DIR%\msys2 ROOT %DK3RDPARTY_DIR%
	
	if exist %MSYS2%\msys2.exe" echo "msys2 already installed" && %return%
	
	%dk_call% dk_info "Installing %MSYS2_FOLDER%"
	%dk_call% dk_download %MSYS2_DL%
	
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	"%DKDOWNLOAD_DIR%\%MSYS2_DL_FILE%" install --root "%MSYS2%" --confirm-command
	
	%dk_call% dk_printVar MSYS2
%endfunction%





::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
	setlocal
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_install
%endfunction%
