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


%dk_call% dk_set GOOGLE_CERT "%JAVA_HOME%\google.cer"
%dk_call% dk_set MAVEN_CERT "%JAVA_HOME%\maven.cer"
if EXIST "%JAVA_HOME%\bin\keytool.exe" 							(%dk_call% dk_set keytool_exe "%JAVA_HOME%\bin\keytool.exe")
if EXIST "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe" 	(%dk_call% dk_set openssl_exe "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe")
if EXIST "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe" 		(%dk_call% dk_set openssl_exe "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe")

%dk_call% dk_killProcess "java.exe"

rem  delete the keys first if they already EXIST
%dk_call% dk_echo deleting "%GOOGLE_CERT%"
"%keytool_exe%" -delete -noprompt -alias google -cacerts -file "%GOOGLE_CERT%" -storepass changeit && %dk_call% dk_echo "keytool: no errors" || %dk_call% dk_error "keytool returned an error"

%dk_call% dk_echo deleting "%MAVEN_CERT%"
"%keytool_exe%" -delete -noprompt -alias maven -cacerts -file "%MAVEN_CERT%" -storepass changeit && %dk_call% dk_echo "keytool: no errors" || %dk_call% dk_error "keytool returned an error"

