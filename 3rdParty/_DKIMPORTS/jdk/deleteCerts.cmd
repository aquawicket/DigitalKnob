@echo off
::if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )


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



:: delete the keys first if they already exist
echo deleting "%GOOGLE_CERT%"
"%KEYTOOL_EXE%" -delete -noprompt -alias google -cacerts -file "%GOOGLE_CERT%" -storepass changeit
echo deleting "%MAVEN_CERT%"
"%KEYTOOL_EXE%" -delete -noprompt -alias maven -cacerts -file "%MAVEN_CERT%" -storepass changeit

echo press and key to continue or wait 5 seconds... && timeout /t 5 > nul
