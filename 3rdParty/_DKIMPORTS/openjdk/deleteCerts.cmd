@echo off
call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd"

call dk_set GOOGLE_CERT "%JAVA_HOME%\google.cer"
call dk_set MAVEN_CERT "%JAVA_HOME%\maven.cer"
call dk_set KEYTOOL_EXE "%JAVA_HOME%\bin\keytool.exe"
if exist "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe" call dk_set OPENSSL_EXE "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe"
if exist "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe" call dk_set OPENSSL_EXE "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe"


::taskkill /IM "java.exe" /F
call dk_killProcess "java.exe"

:: delete the keys first if they already exist
call dk_echo deleting "%GOOGLE_CERT%"
"%KEYTOOL_EXE%" -delete -noprompt -alias google -cacerts -file "%GOOGLE_CERT%" -storepass changeit && call dk_echo "keytool: no errors" || call dk_error "keytool returned an error"

call dk_echo deleting "%MAVEN_CERT%"
"%KEYTOOL_EXE%" -delete -noprompt -alias maven -cacerts -file "%MAVEN_CERT%" -storepass changeit && call dk_echo "keytool: no errors" || call dk_error "keytool returned an error"

