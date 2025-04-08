@echo off

if "%~1" equ "" (goto:DKINSTALL)

:runDKPhp
	set "DKPHP_FUNCTIONS_DIR=%~1"
	set "PHP_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	set "DKSCRIPT_PATH=%DKSCRIPT_PATH:\=/%"

	::###### run script ######'
	"%COMSPEC%" /V:ON /K call "%PHP_EXE%" "%DKSCRIPT_PATH%"
	::"%COMSPEC%" /V:ON /K call "%PHP_EXE%" -r "include('%DKSCRIPT_PATH:\=/%');DKTEST();"
	::###### exit_code ######
::	if %ERRORLEVEL% neq 0 (
::		echo ERROR:%ERRORLEVEL%
::		pause
::	)
::%endfunction%




















:DKINSTALL
	if "%~1" neq "" (goto:eof)

	::###### DK_CMD ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=../DKBatch/functions/")
	if not defined DK_CMD (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)

	::###### Install DKPhp ######
	%dk_call% dk_echo "Installing DKPhp . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PHP_EXE "%dk_call% %DKIMPORTS_DIR%/php-src/DKINSTALL.cmd"
	%dk_call% dk_validate PHP_EXE "%dk_call% dk_PHP_EXE"
	%dk_call% dk_assertPath PHP_EXE

	ftype DKPhp=%COMSPEC% /V:ON /K call "%~f0" "%DKPHP_FUNCTIONS_DIR%" "%PHP_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR/DKPhp/DefaultIcon" "" "REG_SZ" "%PHP_EXE%"
	assoc .php=DKPhp

	%dk_call% dk_success "DKPhp install complete"
%endfunction%