@echo off

set "DIGITALKNOB=C:\Users\Administrator\digitalknob"
set "JAVA_HOME=%DIGITALKNOB%\Development\3rdParty\openjdk-11_windows-x64_bin"
setx JAVA_HOME %DIGITALKNOB%\Development\3rdParty\openjdk-11_windows-x64_bin

set APPPATH=%~dp0
if "%APPPATH%" == "" set APPPATH=.
set "GRADLE_USER_HOME=%APPPATH%\gradle"
setx GRADLE_USER_HOME %APPPATH%\gradle

