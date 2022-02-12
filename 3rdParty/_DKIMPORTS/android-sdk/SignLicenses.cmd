@echo off & %dkbatch%

set "JAVA_HOME=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\openjdk-9.0.4"
call "%JAVA_HOME%\registerJDK.cmd"
set "SDKMANAGER=C:\Users\%USERNAME%\digitalknob\DK\3rdParty\android-sdk\tools\bin\sdkmanager.bat

%SDKMANAGER% --licenses
