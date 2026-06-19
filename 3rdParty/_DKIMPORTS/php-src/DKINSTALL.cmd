rem shebang
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


rem ############ php-src ############
rem # https://github.com/php/php-src.git
rem # https://www.php.net
rem # https://windows.php.net/downloads/releases
rem # https://www.php.net/downloads.php
rem # https://windows.php.net/downloads/releases/php-8.4.13-Win32-vs17-x86.zip
rem # https://windows.php.net/downloads/releases/php-8.4.13-Win32-vs17-x64.zip

:DKINSTALL
rem setlocal
	rem %dk_call% dk_validate vc_redist %dk_call% dk_depend vc_redist
	
	%dk_call% dk_import
	
	set "php_exe=%php-src%/php.exe"
	%dk_call% dk_assertFile php_exe
%endfunction%
