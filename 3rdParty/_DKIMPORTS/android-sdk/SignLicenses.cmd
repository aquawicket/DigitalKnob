@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set JAVA_HOME=C:\Users\Administrator\digitalknob\DK\3rdParty\openjdk-9.0.4
setx JAVA_HOME C:\Users\Administrator\digitalknob\DK\3rdParty\openjdk-9.0.4


set "DIGITALKNOB=C:\Users\%USERNAME%\digitalknob"
set "SDKMANAGER=%DIGITALKNOB%\DK\3rdParty\android-sdk\tools\bin\sdkmanager.bat

%SDKMANAGER% --licenses
