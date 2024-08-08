@echo off

set "DIGITALKNOB_DIR=%HOMEDRIVE%%HOMEPATH%\digitalknob"
set "JAVA_HOME=%DIGITALKNOB_DIR%\Development\3rdParty\openjdk-11_windows-x64_bin"
setx JAVA_HOME %DIGITALKNOB_DIR%\Development\3rdParty\openjdk-11_windows-x64_bin

set APPPATH=%~dp0
if "%APPPATH%" == "" set APPPATH=.
set "GRADLE_USER_HOME=%APPPATH%\gradle"
setx GRADLE_USER_HOME %APPPATH%\gradle

