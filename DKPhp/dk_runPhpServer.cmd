@echo off&::###### DK.cmd #########################################################################################################################
if not exist "%DKBATCH_FUNCTIONS_DIR_%" (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../DKBatch/functions/") 
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%G IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpG")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)
::#################################################################################################################################################

::################################################################################
::# dk_runPhpServer(root_path, ipaddress:port)
::#
::#
:dk_runPhpServer
%setlocal%

	if "%~1" equ "" (set filepath=%CD%)
	set "filepath="C:/Users/Administrator/DigitalKnob/Development/DKJavascript/functions2/"
	set "LOCAL_IP=127.0.0.1"
	set "LOCAL_PORT=2393"
	set "WEB_IP=192.168.1.210"
	set "WEB_PORT=2393"
	
	%dk_call% dk_validate DKIMPORTS_DIR "%dk_call% dk_DKIMPORTS_DIR"
	%dk_call% dk_validate PHP_SRC "%dk_call% %DKIMPORTS_DIR%/php-src/DKINSTALL.cmd"
	
	%dk_call% dk_validate DKPHP_DIR "%dk_call% dk_DKPHP_DIR"
	%dk_call% dk_copy %PHP_SRC%/php.exe %DKPHP_DIR%/php_local.exe OVERWRITE
	%dk_call% dk_copy %PHP_SRC%/php.exe %DKPHP_DIR%/php_web.exe OVERWRITE
	%dk_call% dk_copy %PHP_SRC%/php8ts.dll %DKPHP_DIR%/php8ts.dll OVERWRITE
	
	%dk_call% dk_validate DKBRANCH_DIR "%dk_call% dk_DKBRANCH_DIR"
	cd %DKBRANCH_DIR%
	TASKLIST | FINDSTR php_local.exe || start /min "" "%DKPHP_DIR%\php_local.exe" -S %LOCAL_IP%:%LOCAL_PORT% -t "%filepath%"
	
	%dk_call% dk_todo "dk_runPhpServer.cmd: get local ip address"
	TASKLIST | FINDSTR php_web.exe   || start /min "" "%DKPHP_DIR%\php_web.exe" -S %WEB_IP%:%WEB_PORT% -t "%filepath%"
%endfunction%






::###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	%dk_call% dk_debugFunc 0
	
	%dk_call% dk_runPhpServer
%endfunction%
