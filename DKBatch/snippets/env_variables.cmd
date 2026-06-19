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


echo %0(%*)

rem ###### Load DK Function files (DK_INIT) ######
call ../functions/DK.cmd

:main
	rem Get the PATH environment variable from registry
	call dk_registryGetKey HKCU\Environment PATH PATH_VALUE
	echo PATH_VALUE = %PATH_VALUE%
	echo.
	pause
	
	rem Delete the PATH environment variable from registry
	::call dk_delete_registry_key HKCU\Environment PATH
	echo.
	pause
	
	rem Set the PATH environment variable from registry
	::call dk_registrySetKey HKCU\Environment PATH REG_EXPAND_SZ %PATH_VALUE%
	echo.
	pause
%endfunction%
