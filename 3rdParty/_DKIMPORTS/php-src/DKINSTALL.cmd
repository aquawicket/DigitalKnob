@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)


::### DEPEND ###
::dk_depend(vc_redist) #for VCRUNTIME140.dll


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% "%DKIMPORTS_DIR%/vc_redist/DKINSTALL.cmd"

	%dk_call% dk_validate host_triple "%dk_call% dk_host_triple"
	if defined win_x86_host			(set "PHP_SRC_DL=https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x86.zip")
	if defined win_x86_64_host		(set "PHP_SRC_DL=https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x64.zip")
	if not defined PHP_SRC_DL		(%dk_call% dk_error "PHP_SRC_DL is invalid")

	%dk_call% dk_importVariables %PHP_SRC_DL% IMPORT_PATH %DKIMPORTS_DIR%\php-src

	%dk_call% dk_validate DK3RDPARTY_DIR "%dk_call% dk_DK3RDPARTY_DIR"
	%dk_call% dk_set PHP_EXE "%PHP_SRC%/php.exe"

	if exist "%PHP_EXE%" (%return%)

	%dk_call% dk_download "%PHP_SRC_DL%"
	%dk_call% dk_validate DKDOWNLOAD_DIR "%dk_call% dk_DKDOWNLOAD_DIR"
	%dk_call% dk_smartExtract "%DKDOWNLOAD_DIR%/%PHP_SRC_DL_FILE%" "%PHP_SRC%"

	if not exist "%PHP_EXE%" (%dk_call% dk_error "cannot find PHP_EXE:%PHP_EXE%")
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%