@rem shebang
@echo off&rem ###### DK.cmd #########################################################################################################################
if not defined DKINIT_cmd (
	setlocal enableDelayedExpansion
	if NOT EXIST "%DK.cmd%" (set "DK.cmd=%USERPROFILE%\Digital Knob\Development\DKBatch\functions\DK.cmd")
	if NOT DEFINED DK.cmd (for /F "delims=" %%G IN ('dir /b/s/a:-d "%USERPROFILE%\DK.cmd"') do (set "DK.cmd=%%~fG"))
	if NOT EXIST "!DK.cmd!" (
		start "" /b /wait /min "curl.exe" --silent --location --create-dirs --output "!DK.cmd!" http://aquawicket.com/DigitalKnob/Development/DKBatch/functions/DK.cmd)
	call "!DK.cmd:/=\!" "%%~0" %%*
	exit /b %errorlevel%
)
rem #################################################################################################################################################


if NOT defined dk_runPhpServer_DEFAULT_PATH (set dk_runPhpServer_DEFAULT_PATH=%CD%)
if NOT defined dk_runPhpServer_DEFAULT_PORT (set dk_runPhpServer_DEFAULT_PORT=80)
if NOT defined dk_runPhpServer_DEFAULT_IP 	(set dk_runPhpServer_DEFAULT_IP=127.0.0.1)
rem ################################################################################
rem # dk_runPhpServer(root_path, port)
rem #
rem #
:dk_runPhpServer
%setlocal%

	%dk_call% dk_validate php-src %dk_call% dk_depend php-src
	%dk_call% dk_assertVar php-src

	if "%~1" neq "" (set filepath=%~1) 	else (set filepath=%dk_runPhpServer_DEFAULT_PATH%)
	if "%~2" neq "" (set port=%~2) 		else (set port=%dk_runPhpServer_DEFAULT_PORT%)
	set "LOCAL_IP=%dk_runPhpServer_DEFAULT_IP%"

	%dk_call% dk_IpAddressLocal
	set "WEB_IP=%dk_IpAddressLocal%"

	%dk_call% dk_validate DKPHP_DIR %dk_call% dk_DKBRANCH_DIR
	if NOT EXIST "%DKPHP_DIR%/php_local.exe" (
		%dk_call% dk_copy %php-src%/php.exe "%DKPHP_DIR%/php_local.exe" OVERWRITE
	)
	if NOT EXIST "%DKPHP_DIR%/php_web.exe" (
		%dk_call% dk_copy %php-src%/php.exe "%DKPHP_DIR%/php_web.exe" OVERWRITE
	)
	if NOT EXIST "%DKPHP_DIR%/php8ts.dll" (
		%dk_call% dk_copy "%php-src%/php8ts.dll" "%DKPHP_DIR%/php8ts.dll" OVERWRITE
	)

	rem %dk_call% dk_validate DKBRANCH_DIR %dk_call% dk_DKBRANCH_DIR
	rem %dk_call% dk_chdir %DKBRANCH_DIR%
	
	%dk_call% dk_validate tasklist.exe %dk_call% dk_findFile tasklist.exe
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	echo start /min "" "%DKPHP_DIR%/php_local.exe" -S %LOCAL_IP%:%port% -t "%filepath%"
	"%tasklist.exe:/=\%" | %findstr.exe:/=\% php_local.exe || start /min "" "%DKPHP_DIR%/php_local.exe" -S %LOCAL_IP%:%port% -t "%filepath%"

	rem %dk_call% dk_todo "dk_runPhpServer.cmd: get local ip address"
	%dk_call% dk_validate findstr.exe %dk_call% dk_findFile findstr.exe
	"%tasklist.exe:/=\%" | %findstr.exe:/=\% php_web.exe   || start /min "" "%DKPHP_DIR%/php_web.exe" -S %WEB_IP%:%port% -t "%filepath%"
%endfunction%






rem ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ###### DKTEST ######
:DKTEST
%setlocal%
	
	%dk_call% dk_validate DKBRANCH_DIR   %dk_call% dk_DKBRANCH_DIR
	%dk_call% dk_runPhpServer "%DKBRANCH_DIR%/DKJavascript/functions2/" 2393
%endfunction%
