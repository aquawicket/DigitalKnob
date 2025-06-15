@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


::### DEPEND ###
::dk_depend(vc_redist) #for VCRUNTIME140.dll


::####################################################################
::# DKINSTALL
::#
:DKINSTALL
::setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% "%DKIMPORTS_DIR%/vc_redist/DKINSTALL.cmd"

	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	if defined Windows_X86_Host		(set "PHP_SRC_IMPORT=https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x86.zip")
	if defined Windows_X86_64_Host	(set "PHP_SRC_IMPORT=https://windows.php.net/downloads/releases/php-8.0.30-Win32-vs16-x64.zip")
	%dk_call% dk_assertVar PHP_SRC_IMPORT

	%dk_call% dk_importVariables %PHP_SRC_IMPORT% IMPORT_PATH %DKIMPORTS_DIR%\php-src

	set "PHP_EXE=%PHP_SRC%/php.exe"

	if exist "%PHP_EXE%" (%return%)

	%dk_call% dk_download "%PHP_SRC_IMPORT%"
	%dk_call% dk_smartExtract "%dk_download%" "%PHP_SRC%"

	%dk_call% dk_assertFile PHP_EXE
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%