@echo off
if not defined in_subprocess (cmd /k set in_subprocess=y ^& %0 %*) & exit )

set "JAVA_HOME=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openjdk-9.0.4"
"%JAVA_HOME%\registerJDK.cmd"
set "SDKMANAGER=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\android-sdk\tools\bin\sdkmanager.bat

%SDKMANAGER% --licenses
