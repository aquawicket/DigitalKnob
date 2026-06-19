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

echo ###### install_crosstool.cmd ######
%dk_call% dk_validate DK3RDPARTY_DIR %dk_call% dk_DK3RDPARTY_DIR
set "CYGWIN=%DK3RDPARTY_DIR%/cygwin-setup-x86_64"

%dk_call% dk_validate DKIMPORTS_DIR %dk_call% dk_DKIMPORTS_DIR

rem /cygdrive/c/Users/Administrator/Digital Knob/Development/3rdParty/_DKIMPORTS/cygwin/crosstool-ng-build.sh
set "crosstool_ng_build_sh=%DKIMPORT_DIR%/cygwin/crosstool-ng-build.sh")
set "crosstool_ng_build_sh=!crosstool_ng_build_sh:%SystemDrive%\=/cygdrive/c/!")
%cygwin%/bin/bash.exe --login -c '%crosstool_ng_build_sh:\=/%'