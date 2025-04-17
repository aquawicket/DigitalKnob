@echo off
if not defined DKBATCH_FUNCTIONS_DIR_ (set "DKBATCH_FUNCTIONS_DIR_=%CD:\=/%/../../../DKBatch/functions/")
if not exist "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" for /F "tokens=*" %%A IN ('where /r "%USERPROFILE%" DK.cmd') do (set "DKBATCH_FUNCTIONS_DIR_=%%~dpA")
if not defined DK.cmd (call "%DKBATCH_FUNCTIONS_DIR_%DK.cmd" "%~0" %*)

%dk_call% dk_set GOOGLE_CERT "%JAVA_HOME%\google.cer"
%dk_call% dk_set MAVEN_CERT "%JAVA_HOME%\maven.cer"
%dk_call% dk_set KEYTOOL_EXE "%JAVA_HOME%\bin\keytool.exe"
if exist "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe" (%dk_call% dk_set OPENSSL_EXE "%ProgramFiles(x86)%\OpenSSL-win32\bin\openssl.exe")
if exist "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe" (%dk_call% dk_set OPENSSL_EXE "%ProgramFiles%\OpenSSL-Win64\bin\openssl.exe")


::taskkill /IM "java.exe" /F
%dk_call% dk_killProcess "java.exe"

:: delete the keys first if they already exist
%dk_call% dk_echo deleting "%GOOGLE_CERT%"
"%KEYTOOL_EXE%" -delete -noprompt -alias google -cacerts -file "%GOOGLE_CERT%" -storepass changeit && %dk_call% dk_echo "keytool: no errors" || %dk_call% dk_error "keytool returned an error"

%dk_call% dk_echo deleting "%MAVEN_CERT%"
"%KEYTOOL_EXE%" -delete -noprompt -alias maven -cacerts -file "%MAVEN_CERT%" -storepass changeit && %dk_call% dk_echo "keytool: no errors" || %dk_call% dk_error "keytool returned an error"

