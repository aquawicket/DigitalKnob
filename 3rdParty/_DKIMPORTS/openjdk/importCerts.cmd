@echo off
if not defined DKINIT call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" %~0 %*

:: NOTE: you'll need to download and install openssl for this, link below
:: https://slproweb.com/products/Win32OpenSSL.html
:: https://slproweb.com/download/Win32OpenSSL_Light-1_1_1w.exe

set "GOOGLE_CERT=%JAVA_HOME%\google.cer"
set "MAVEN_CERT=%JAVA_HOME%\maven.cer"
set "KEYTOOL_EXE=%JAVA_HOME%\bin\keytool.exe"
if exist "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe" set "OPENSSL_EXE=%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe"
if exist "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe" set "OPENSSL_EXE=%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe"

::keytool -import -noprompt -file PathToCertificate -alias SomeCertificateAlias -keystore PathToKeyStore -storepass KeyStorePassword
:: call dk_echo -n | %OPENSSL_EXE% ca -config %JDK%\ssl\openssl.cnf
:: call dk_echo -n | %OPENSSL_EXE% ca -config %JDK%\ssl\openssl.cnf -policy policy_anything -extensions ssl_server -out requests/server-signed.pem -infiles requests/server.pem


::The /F parameter tells taskkill to Force the process(es) to kill.
::The /IM parameter allows you to specify the name of the process executable(s) to kill.
::The /T switch specifies to terminate all child processes along with the parent process
taskkill /F /IM /T "java.exe" 

:: list the keys
:: keytool.exe -list
:: keytool.exe -cacerts -list

:: create and import the google.cer key
call dk_echo -n | "%OPENSSL_EXE%" s_client -connect google.com:443 | "%OPENSSL_EXE%" x509 > "%GOOGLE_CERT%"
"%KEYTOOL_EXE%" -import -noprompt -alias google -cacerts -file "%GOOGLE_CERT%" -storepass changeit && call dk_echo "keytool: no errors" || call dk_error "keytool returned an error"

:: create and import the maven.cer key
call dk_echo -n | "%OPENSSL_EXE%" s_client -connect repo.maven.apache.org:443 | "%OPENSSL_EXE%" x509 > "%MAVEN_CERT%"
"%KEYTOOL_EXE%" -import -noprompt -alias maven -cacerts -file "%MAVEN_CERT%" -storepass changeit && call dk_echo "keytool: no errors" || call dk_error "keytool returned an error"
