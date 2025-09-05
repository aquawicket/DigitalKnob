@echo off&::###### DK.cmd #########################################################################################################################
if NOT defined DKBATCH_FUNCTIONS_DIR_ (set DKBATCH_FUNCTIONS_DIR_=%USERPROFILE%/DigitalKnob/Development/DKBatch/functions/)
if NOT EXIST "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if NOT defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################


if NOT defined dk_runPhpServer_DEFAULT_PATH (set dk_runPhpServer_DEFAULT_PATH=%CD%)
if NOT defined dk_runPhpServer_DEFAULT_PORT (set dk_runPhpServer_DEFAULT_PORT=80)
if NOT defined dk_runPhpServer_DEFAULT_IP 	(set dk_runPhpServer_DEFAULT_IP=127.0.0.1)
::################################################################################
::# dk_runPhpServer(root_path, port)
::#
::#
:dk_runPhpServer
%setlocal%

	%dk_call% dk_depend php-src
	%dk_call% dk_assertVar php-src

	if "%~1" neq "" (set filepath=%~1) 	else (set filepath=%dk_runPhpServer_DEFAULT_PATH%)
	if "%~2" neq "" (set port=%~2) 		else (set port=%dk_runPhpServer_DEFAULT_PORT%)
	set "LOCAL_IP=%dk_runPhpServer_DEFAULT_IP%"

	%dk_call% dk_IpAddressLocal
	set "WEB_IP=%dk_IpAddressLocal%"

	%dk_call% dk_validate DKPHP_DIR "%dk_call% dk_DKBRANCH_DIR"
	if NOT EXIST "%DKPHP_DIR%/php_local.exe" (
		%dk_call% dk_copy %php-src%/php.exe "%DKPHP_DIR%/php_local.exe" OVERWRITE
	)
	if NOT EXIST "%DKPHP_DIR%/php_web.exe" (
		%dk_call% dk_copy %php-src%/php.exe "%DKPHP_DIR%/php_web.exe" OVERWRITE
	)
	if NOT EXIST "%DKPHP_DIR%/php8ts.dll" (
		%dk_call% dk_copy "%php-src%/php8ts.dll" "%DKPHP_DIR%/php8ts.dll" OVERWRITE
	)

	::%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	::%dk_call% dk_chdir %DKBRANCH_DIR%

	echo start /min "" "%DKPHP_DIR%/php_local.exe" -S %LOCAL_IP%:%port% -t "%filepath%"
	TASKLIST | FINDSTR php_local.exe || start /min "" "%DKPHP_DIR%/php_local.exe" -S %LOCAL_IP%:%port% -t "%filepath%"

	::%dk_call% dk_todo "dk_runPhpServer.cmd: get local ip address"
	TASKLIST | FINDSTR php_web.exe   || start /min "" "%DKPHP_DIR%/php_web.exe" -S %WEB_IP%:%port% -t "%filepath%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	echo 57
	%dk_call% dk_runPhpServer "C:/Users/Administrator/DigitalKnob/Development/DKJavascript/functions2/" 2393
%endfunction%
