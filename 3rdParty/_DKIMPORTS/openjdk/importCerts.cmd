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

rem  NOTE: you'll need to download and install openssl for this, link below
rem  https://slproweb.com/products/Win32OpenSSL.html
rem  https://slproweb.com/download/Win32OpenSSL_Light-1_1_1w.exe

set "GOOGLE_CERT=%JAVA_HOME%\google.cer"
set "MAVEN_CERT=%JAVA_HOME%\maven.cer"
set "keytool_exe=%JAVA_HOME%\bin\keytool.exe"
if EXIST "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe" (set "openssl_exe=%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe")
if EXIST "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe" (set "openssl_exe=%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe")

rem keytool -import -noprompt -file PathToCertificate -alias SomeCertificateAlias -keystore PathToKeyStore -storepass KeyStorePassword
rem  %dk_call% dk_echo -n | %openssl_exe% ca -config %JDK%\ssl\openssl.cnf
rem  %dk_call% dk_echo -n | %openssl_exe% ca -config %JDK%\ssl\openssl.cnf -policy policy_anything -extensions ssl_server -out requests/server-signed.pem -infiles requests/server.pem


rem The /F parameter tells taskkill to Force the process(es) to kill.
rem The /IM parameter allows you to specify the name of the process executable(s) to kill.
rem The /T switch specifies to terminate all child processes along with the parent process
taskkill /F /IM /T "java.exe"

rem  list the keys
rem  keytool.exe -list
rem  keytool.exe -cacerts -list

rem  create and import the google.cer key
%dk_call% dk_echo -n | "%openssl_exe%" s_client -connect google.com:443 | "%openssl_exe%" x509 > "%GOOGLE_CERT%"
"%keytool_exe%" -import -noprompt -alias google -cacerts -file "%GOOGLE_CERT%" -storepass changeit && %dk_call% dk_echo "keytool: no errors" || %dk_call% dk_error "keytool returned an error"

rem  create and import the maven.cer key
%dk_call% dk_echo -n | "%openssl_exe%" s_client -connect repo.maven.apache.org:443 | "%openssl_exe%" x509 > "%MAVEN_CERT%"
"%keytool_exe%" -import -noprompt -alias maven -cacerts -file "%MAVEN_CERT%" -storepass changeit && %dk_call% dk_echo "keytool: no errors" || %dk_call% dk_error "keytool returned an error"
