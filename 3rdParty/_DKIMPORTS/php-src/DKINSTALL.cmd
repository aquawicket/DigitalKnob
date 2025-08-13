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
	
	%dk_call% dk_getFileParams	"%~dp0/dkconfig.txt"
	%dk_call% dk_depend vc_redist

	%dk_call% dk_validate Host_Tuple "%dk_call% dk_Host_Tuple"
	set "php_src_Import=!php_src_%Host_Tuple%_Import!"
	%dk_call% dk_assertVar PHP_SRC_IMPORT

	%dk_call% dk_importVariables %php_src_Import% IMPORT_PATH %DKIMPORTS_DIR%\php-src
	%dk_call% dk_assertVar PHP_SRC

	set "PHP_EXE=%PHP_SRC%/php.exe"
	if exist "%PHP_EXE%" (%return%)

	%dk_call% dk_download "%php_src_Import%"
	%dk_call% dk_smartExtract "%dk_download%" "%PHP_SRC%"
	%dk_call% dk_assertFile PHP_EXE
%endfunction%




::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
setlocal
	%dk_call% dk_debugFunc 0

	%dk_call% DKINSTALL
%endfunction%