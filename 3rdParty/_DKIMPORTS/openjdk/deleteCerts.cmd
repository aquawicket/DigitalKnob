@echo off
call ..\..\..\DKBatch\functions\DK.cmd

set "GOOGLE_CERT=%JAVA_HOME%\google.cer"
set "MAVEN_CERT=%JAVA_HOME%\maven.cer"
set "KEYTOOL_EXE=%JAVA_HOME%\bin\keytool.exe"
if exist "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe" set "OPENSSL_EXE=%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe"
if exist "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe" set "OPENSSL_EXE=%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe"


taskkill /IM "java.exe" /F

:: delete the keys first if they already exist
echo deleting "%GOOGLE_CERT%"
"%KEYTOOL_EXE%" -delete -noprompt -alias google -cacerts -file "%GOOGLE_CERT%" -storepass changeit

echo deleting "%MAVEN_CERT%"
"%KEYTOOL_EXE%" -delete -noprompt -alias maven -cacerts -file "%MAVEN_CERT%" -storepass changeit

