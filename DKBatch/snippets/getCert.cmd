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

%dk_call% dk_validate DK3RDPARTY_DIR	%dk_call% dk_DK3RDPARTY_DIR
set openssl="%DK3RDPARTY_DIR%/openssl-1.0.2h-vs2015/bin/opensslMT"
set certs="%DK3RDPARTY_DIR%/openjdk-9.0.4_windows-x64_bin/lib/security"
set keytool="%DK3RDPARTY_DIR%/openjdk-9.0.4_windows-x64_bin/bin/keytool"
echo -n | %openssl:/=\% s_client -connect *.google.com:443 | %openssl:/=\% x509 > %certs:/=\%\google.cer
%keytool:/=\% -import -alias google4 -keystore %certs:/=\%\cacerts -file %certs:/=\%\google.cer
