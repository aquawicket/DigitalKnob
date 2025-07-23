@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


if not defined dk_runPhpServer_DEFAULT_PATH (set dk_runPhpServer_DEFAULT_PATH=%CD%)
if not defined dk_runPhpServer_DEFAULT_PORT (set dk_runPhpServer_DEFAULT_PORT=80)
if not defined dk_runPhpServer_DEFAULT_IP 	(set dk_runPhpServer_DEFAULT_IP=127.0.0.1)
::################################################################################
::# dk_runPhpServer(path, port)
::#
::#
:dk_runPhpServer
%setlocal%
	
	%dk_call% dk_depend php-src
	
	if "%~1" neq "" (set path=%~1) 	else (set path=%dk_runPhpServer_DEFAULT_PATH%)
	if "%~2" neq "" (set port=%~2) 	else (set port=%dk_runPhpServer_DEFAULT_PORT%)
	set "LOCAL_IP=%dk_runPhpServer_DEFAULT_IP%"
	
	%dk_call% dk_IpAddressLocal
	set "WEB_IP=%dk_IpAddressLocal%"
	
	%dk_call% dk_validate DKPHP_DIR "%dk_call% dk_DKPHP_DIR"
	%dk_call% dk_assertPath "%PHP_SRC%/php.exe"
	%dk_call% dk_assertPath "%PHP_SRC%/php8ts.dll"
	
	if not exist "%DKPHP_DIR%/php_local.exe" (
		%dk_call% dk_copy "%PHP_SRC%/php.exe" "%DKPHP_DIR%/php_local.exe" OVERWRITE
	)
	if not exist "%DKPHP_DIR%/php_web.exe" (
		%dk_call% dk_copy "%PHP_SRC%/php.exe" "%DKPHP_DIR%/php_web.exe" OVERWRITE
	)
	if not exist "%DKPHP_DIR%/php8ts.dll" (
		%dk_call% dk_copy "%PHP_SRC%/php8ts.dll" "%DKPHP_DIR%/php8ts.dll" OVERWRITE
	)
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_chdir %DKBRANCH_DIR%
	TASKLIST | FINDSTR php_local.exe || start /min "" "%DKPHP_DIR%/php_local.exe" -S %LOCAL_IP%:%port% -t "%path%"
	
	%dk_call% dk_todo "dk_runPhpServer.cmd: get local ip address"
	TASKLIST | FINDSTR php_web.exe   || start /min "" "%DKPHP_DIR%/php_web.exe" -S %WEB_IP%:%port% -t "%path%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	%dk_call% dk_runPhpServer "%DKBRANCH_DIR%" 80
%endfunction%
