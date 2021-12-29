:: NOTE: you'll need to download and install openssl for this, link below
:: https://slproweb.com/products/Win32OpenSSL.html
:: https://slproweb.com/download/Win32OpenSSL-1_1_1L.exe
@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

echo This will download the .cer file from google and put it into the JDK keystore.
echo When asked, the PASSWORD = "changeit"
echo also type "yes" when asked
echo press and key to continue && timeout /t 60 > nul

if exist "C:\Windows\System32\openssl.exe" set "OPENSSL_EXE=C:\Windows\System32\openssl.exe"
if exist "C:\Windows\System32\OpenSSL-win32\bin\openssl.exe" set "OPENSSL_EXE=C:\Windows\System32\OpenSSL-win32\bin\openssl.exe"
if exist "C:\Program Files (x86)\OpenSSL-win32\bin\openssl.exe" set "OPENSSL_EXE=C:\Program Files (x86)\OpenSSL-win32\bin\openssl.exe"
if exist "C:\Program Files\OpenSSL-win32\bin\openssl.exe" set "OPENSSL_EXE=C:\Program Files\OpenSSL-win32\bin\openssl.exe"
::if exist "C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openssl-1.0.2h-vs2015\bin\opensslMT.exe" set "OPENSSL_EXE=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openssl-1.0.2h-vs2015\bin\opensslMT.exe"
set GOOGLE_CER="C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openjdk-9.0.4_windows-x64_bin\google.cer"
set MAVEN_CER="C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openjdk-9.0.4_windows-x64_bin\maven.cer"
set KEYTOOL_EXE="C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openjdk-9.0.4_windows-x64_bin\bin\keytool.exe"
set CACERTS="C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openjdk-9.0.4_windows-x64_bin\lib\security\cacerts"

::echo -n | %OPENSSL_EXE% ca -config C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openssl-1.0.2h-vs2015\ssl\openssl.cnf
::echo -n | %OPENSSL_EXE% ca -config C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openssl-1.0.2h-vs2015\ssl\openssl.cnf -policy policy_anything -extensions ssl_server -out requests/server-signed.pem -infiles requests/server.pem

echo -n | "%OPENSSL_EXE%" s_client -connect google.com:443 | "%OPENSSL_EXE%" x509 > "%GOOGLE_CER%"
"%KEYTOOL_EXE%" -import -alias google -cacerts -file "%GOOGLE_CER%"

echo -n | "%OPENSSL_EXE%" s_client -connect repo.maven.apache.org:443 | "%OPENSSL_EXE%" x509 > "%MAVEN_CER%"
"%KEYTOOL_EXE%" -import -alias maven -cacerts -file "%MAVEN_CER%"

echo press and key to continue && timeout /t 60 > nul