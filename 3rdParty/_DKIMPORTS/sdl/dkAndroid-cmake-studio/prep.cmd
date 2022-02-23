@echo off

set "DIGITALKNOB=C:\Users\Administrator\digitalknob"
set "JAVA_HOME=%DIGITALKNOB%\DK\3rdParty\openjdk-11"
setx JAVA_HOME %DIGITALKNOB%\DK\3rdParty\openjdk-11

set APPPATH=%~dp0
if "%APPPATH%" == "" set APPPATH=.
set "GRADLE_USER_HOME=%APPPATH%\gradle"
setx GRADLE_USER_HOME %APPPATH%\gradle

