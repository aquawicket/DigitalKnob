@echo off
if "%~1" == "" (goto dk_install)

:runDKPhp
	set "DKPHP_FUNCTIONS_DIR=%~1"
	set "PHP_EXE=%~2"
	set "DKSCRIPT_PATH=%~3"
	
	::###### run script ######
	%COMSPEC% /V:ON /K call %PHP_EXE% -Command %DKSCRIPT_PATH%; exit $LASTEXITCODE && (echo returned TRUE) || (echo returned FALSE)
	
	::###### exit_code ######
	if %ERRORLEVEL% neq 0 (
		echo ERROR:%ERRORLEVEL%
		pause
	)
	
	::###### reload ######
::	if not exist %~dp0\reload (goto:eof)
::	del %~dp0\reload
::	cls
::	goto runDKPhp
%endfunction%




















:dk_install
	::###### DKINIT ######
	if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=..\DKBatch\functions\")
	if not defined DKINIT (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*)
	
	::###### Install DKPhp ######
	%dk_call% dk_echo "Installing DKPhp . . ."
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PHP_EXE "call %DKIMPORTS_DIR%\php\dk_install.cmd"
	%dk_call% dk_validate PHP_EXE "%dk_call% dk_PHP_EXE"
	
	
	%dk_call% dk_registryDeleteKey "HKCR\DKPhp"
	
::	%dk_call% dk_validate COMSPEC "%dk_call% dk_COMSPEC"
	ftype DKPhp=%COMSPEC% /c call "%~f0" "%DKPHP_FUNCTIONS_DIR%" "%PHP_EXE%" "%%1" %*
	%dk_call% dk_registrySetKey "HKCR\DKPhp\DefaultIcon" "" "REG_SZ" "%PHP_EXE%"
	
	%dk_call% dk_registryDeleteKey "HKCR\.php"
	%dk_call% dk_registryDeleteKey "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.php"
	assoc .php=DKPhp
	
	%dk_call% dk_success "DKPhp install complete"
%endfunction%