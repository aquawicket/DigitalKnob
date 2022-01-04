:: NOTE: you'll need to download and install openssl for this, link below
:: https://slproweb.com/products/Win32OpenSSL.html
:: https://slproweb.com/download/Win32OpenSSL-1_1_1L.exe
@echo off
::if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )


::echo This will download the .cer file from google and put it into the JDK keystore.
::echo When asked, the PASSWORD = "changeit"
::echo also type "yes" when asked
::echo press and key to continue && timeout /t 60 > nul


set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
::set "JDK=%DIGITALKNOB%\DK\3rdParty\openjdk-8u41-b04-windows-i586-14_jan_2020"
set "JDK=%DIGITALKNOB%\DK\3rdParty\openjdk-9.0.4_windows-x64_bin"
set "GOOGLE_CERT=%JDK%\google.cer"
set "MAVEN_CERT=%JDK%\maven.cer"
set "KEYTOOL_EXE=%JDK%\bin\keytool.exe"
set "CACERTS=%JDK%\lib\security\cacerts"

::set "OPENSSL=C:\Program Files\OpenSSL-Win64"
if exist "C:\Windows\System32\openssl.exe" set "OPENSSL_EXE=C:\Windows\System32\openssl.exe"
if exist "C:\Windows\System32\OpenSSL-win32\bin\openssl.exe" set "OPENSSL_EXE=C:\Windows\System32\OpenSSL-win32\bin\openssl.exe"
if exist "C:\Program Files (x86)\OpenSSL-win32\bin\openssl.exe" set "OPENSSL_EXE=C:\Program Files (x86)\OpenSSL-win32\bin\openssl.exe"
if exist "C:\Program Files\OpenSSL-Win64\bin\openssl.exe" set "OPENSSL_EXE=C:\Program Files\OpenSSL-Win64\bin\openssl.exe"
::if exist "%OPENSSL%\bin\opensslMT.exe" set "OPENSSL_EXE=%OPENSSL%\bin\opensslMT.exe"
::if exist "%OPENSSL%\bin\openssl.exe" set "OPENSSL_EXE=%OPENSSL%\bin\openssl.exe"

::keytool -import -noprompt -file PathToCertificate -alias SomeCertificateAlias -keystore PathToKeyStore -storepass KeyStorePassword
:: echo -n | %OPENSSL_EXE% ca -config %JDK%\ssl\openssl.cnf
:: echo -n | %OPENSSL_EXE% ca -config %JDK%\ssl\openssl.cnf -policy policy_anything -extensions ssl_server -out requests/server-signed.pem -infiles requests/server.pem

:: list the keys
:: keytool.exe -list
:: keytool.exe -cacerts -list

:: create and import the google.cer key
echo -n | "%OPENSSL_EXE%" s_client -connect google.com:443 | "%OPENSSL_EXE%" x509 > "%GOOGLE_CERT%"
"%KEYTOOL_EXE%" -import -noprompt -alias google -cacerts -file "%GOOGLE_CERT%" -storepass changeit

:: create and import the maven.cer key
echo -n | "%OPENSSL_EXE%" s_client -connect repo.maven.apache.org:443 | "%OPENSSL_EXE%" x509 > "%MAVEN_CERT%"
"%KEYTOOL_EXE%" -import -noprompt -alias maven -cacerts -file "%MAVEN_CERT%" -storepass changeit

echo press and key to continue or wait 5 seconds... && timeout /t 5 > nul
