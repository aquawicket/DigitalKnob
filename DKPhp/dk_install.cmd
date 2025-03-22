@echo off
if "%~1" equ "" (goto:dk_install)

:runDKPhp
	set "DKPHP_FUNCTIONS_DIR=%~1"
	set "PHP_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"

	::###### run script ######
	"%COMSPEC%" /V:ON /K call "%PHP_EXE%" -Command "%DKSCRIPT_PATH%"; exit $LASTEXITCODE && (echo returned TRUE) || (echo returned FALSE)

	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
%endfunction%




















:dk_install
	if "%~1" neq "" (goto:eof)

	::###### DK_CMD ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

	::###### Install DKPhp ######
	%dk_call% dk_echo "Installing DKPhp . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PHP_EXE "%dk_call% %DKIMPORTS_DIR%/php/dk_install.cmd"
	%dk_call% dk_validate PHP_EXE "%dk_call% dk_PHP_EXE"

	ftype DKPhp=%COMSPEC% /V:ON /K call "%~f0" "%DKPHP_FUNCTIONS_DIR%" "%PHP_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKPhp/DefaultIcon" "" "REG_SZ" "%PHP_EXE%"
	assoc .php=DKPhp

	%dk_call% dk_success "DKPhp install complete"
%endfunction%